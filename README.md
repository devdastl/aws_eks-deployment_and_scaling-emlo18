# AWS EKS deployment (EMLO assignment 18)
This project focuses on deploying three services to perform GPT2 based inference on AWS EKS service. This project is a part of assignment from EMLO.

## Introduction
This project uses Helm to deploy three services on AWS EKS created cluster:
- FastAPI based web service
- GPT2 inference server
- Redis DataBase for caching

We will also setup Cluster-Autoscaling to automatically scale nodes if required as well as Horizontal-Pod-Autoscaling to scale our GPT pod when load increases.
## Deployment overview
First lets go through the overview and flow of deployment. Below is the flow diagram representing our target deployment workflow:
<img src="img/deploy_wf.png" alt= “” width="" height="">
<br>

Lets go through few important points:
- We are using single Node based deployemnt using minikube.
- We have two isolated and identical deployments on two different namespace `dev` & `pro`
- We have two different ingress and persistant volume as they can't be isolated via namespace.
- We have `web-server`, `gpt-inference-server` and `redis database.`
    - web-server has single pod replica
    - gpt-inference-server has two replica of pod 
    - single pod for redis database.

## Prerequisite
Below are few required Prerequisite to deploy this project:
- Minikube installed
- Docker and docker-compose
- Helm installed
- `make` to build project via Makefile
- `eksctl` cli installed
- aws cli logged in with proper EKS access

## Steps to perform deployment
Lets go through the steps to perform EKS cluster creation and helm deployment

### 1. Building and pushing images

### 2. Creating Cluster using EKS on AWS

### 3. Setting up ingress for internet access & setting up Cluster-Autoscaling

### 4. Starting service deployment using Helm

## Stress testing deployment

## Inference output
Lest see how to use `mykube-app.com/docs` api page to perform inference.
1. Access the API page `http://mykube-app.com/docs`. You will see below page.
<img src="img/step-1.PNG" alt= “” width="" height="">
2. Try out first post api and add your text as shown below.
<img src="img/step-2.PNG" alt= “” width="" height="">
3. Execute and see the output text.
<img src="img/step-3.PNG" alt= “” width="" height="">
4. You can try it with same input and inference will be much faster as the data is been cached for faster inferece.
