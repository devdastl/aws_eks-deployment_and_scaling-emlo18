USERNAME = devdastl
PROJECT = emlo
TAG = assignment17-v1

#setup make commands
help:
	@echo "Makefile supported commands:"
	@echo "1. build-images: Build required images"
	@echo "2. push-images: Push images to docker registery"
	@echo "3. create-eks-cluster: create EKS cluster on AWS"
	@echo "4. set-hpa-ca: Set policy and account for Pod scaling and Cluster scaling"
	@echo "5. helm-deployment: Start deployment using helm on EKS cluster"
	@echo "6. kill-helm-deployment: Uninstall helm deployment from EKS cluster"

build-images:
	@echo "building docker image for web service"
	cd src/web-server-gpt && docker build -t ${USERNAME}/${PROJECT}-web-server:${TAG} .

	@echo "building docker image for gpt model service"
	cd src/model-server-gpt && docker build -t ${USERNAME}/${PROJECT}-model-server:${TAG} .

push-images:
	@echo "pushing images to ${USERNAME} account under ${PROJECT}"
	@echo "make sure USERNAME and PROJECT is set properly docker is logged in"
	docker push ${USERNAME}/${PROJECT}-web-server:${TAG}
	docker push ${USERNAME}/${PROJECT}-model-server:${TAG}

create-eks-cluster:
	@echo "Creating EKS cluster from eks-cluster.yaml file"
	eksctl create cluster -f eks-cluster.yaml

set-hpa-ca:
	@echo "setting up policy and creating service-account for Cluster Autoscaling and Horizontal Pod Scaling"
	@echo "Running irsa.sh script"
	sh irsa.sh

helm-deployment:
	@echo "Deploying services using helm on EKS"
	helm install gpt-server helm_gpt_deployment/ --values helm_gpt_deployment/values.yaml

kill-helm-deployment:
	helm uninstall gpt-server

delete-eks-cluster:
	@echo "Deleting EKS cluster from eks-cluster.yaml file"
	eksctl delete cluster -f eks-cluster.yaml

test-dockercompose:
	@echo "starting services with docker compose"
	@echo " service is will expose on localhost:8050 "
	docker compose -f test_docker_compose.yml up




