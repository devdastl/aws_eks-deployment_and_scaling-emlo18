import requests
import random
import urllib.parse
import threading
import time

num_requests = 1  # Initial number of requests to send

# Number of iterations before increasing parallel requests
iterations_before_increase = 2  # Increase after every 5 iterations
max_parallel_requests = 6  # Maximum number of parallel requests

# Number of iterations to run the test
num_iterations = 50  # Define the total number of iterations

current_iteration = 0
current_parallel_requests = 0


words = [
    "apple", "banana", "cherry", "date", "elderberry",
    "fig", "grape", "honeydew", "kiwi", "lemon",
    "mango", "orange", "papaya", "quince", "raspberry",
    "strawberry", "tangerine", "watermelon", "blueberry", "blackberry",
    "apricot", "coconut", "guava", "lime", "pear",
    "plum", "peach", "pineapple", "cantaloupe", "cranberry",
    "grapefruit", "pomegranate", "avocado", "melon", "kiwifruit",
    "nectarine", "passionfruit", "tamarind", "boysenberry", "lingonberry",
    "elderflower", "loganberry", "mulberry", "mulberry", "persimmon",
    "carambola", "gooseberry", "plantain", "pawpaw", "starfruit"
]

url = 'http://k8s-default-webserve-2e58196f1d-1030968271.ap-south-1.elb.amazonaws.com/gpt2-infer'

headers = {
  'accept': 'application/json',
  'Content-Type': 'application/x-www-form-urlencoded'
}

def send_requests():

    random_sentence = ' '.join(random.sample(words, 5))
    text = urllib.parse.quote_plus(random_sentence)
    payload = f'text_input={text}'
    
    start_time = time.perf_counter()
    response = requests.request("POST", url, headers=headers, data=payload)
    end_time = time.perf_counter()

    print(f"inference time = {end_time-start_time} for iteration = {current_iteration} handling {current_parallel_requests} parallel requests")
    print(random_sentence, response.status_code)
    
# Outer loop for multiple iterations
for iteration in range(1, num_iterations + 1):

    #log current values to print
    current_iteration = iteration
    current_parallel_requests = num_requests

    # Create and start threads for concurrent requests
    threads = []
    for _ in range(num_requests):
        thread = threading.Thread(target=send_requests)
        threads.append(thread)
        thread.start()

    # Wait for all threads to finish
    for thread in threads:
        thread.join()

    print(f"Iteration {iteration} complete")

    # Check if it's time to increase the number of parallel requests
    if iteration % iterations_before_increase == 0 and num_requests < max_parallel_requests:
        num_requests += 1

print("Stress test complete")
