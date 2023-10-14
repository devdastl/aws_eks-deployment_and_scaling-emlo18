#common variables 
export ACCOUNT=810561421519
export CLUSTER=emlo-test-cluster


#Create policy and steps for Application Load Balancer for internet access

eksctl utils associate-iam-oidc-provider --region ap-south-1 --cluster ${CLUSTER} --approve

aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://policy-file/iam-policy.json

sleep 2

eksctl create iamserviceaccount \
--cluster=${CLUSTER} \
--namespace=kube-system \
--name=aws-load-balancer-controller \
--attach-policy-arn=arn:aws:iam::${ACCOUNT}:policy/AWSLoadBalancerControllerIAMPolicy \
--override-existing-serviceaccounts \
--region ap-south-1 \
--approve

sleep 2

helm repo add eks https://aws.github.io/eks-charts

helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=${CLUSTER} --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller

sleep 2

#Create policy for Cluster scaling
aws iam create-policy --policy-name AWSClusterAutoScalerIAMPolicy --policy-document file://policy-file/cas-iam-policy.json

sleep 2

eksctl create iamserviceaccount \
--cluster=${CLUSTER} \
--namespace=kube-system \
--name=cluster-autoscaler \
--attach-policy-arn=arn:aws:iam::${ACCOUNT}:policy/AWSClusterAutoScalerIAMPolicy \
--override-existing-serviceaccounts \
--region ap-south-1 \
--approve

# install metric serverb for Horizontal Pod Scaling
wget -P helm_gpt_deployment/templates/ https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
