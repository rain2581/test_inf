#!/bin/bash
#install latest awscli
#Test commit 
# Second commit
pip3 install awscli --upgrade --user
# install aws-iam-authenticator
wget https://amazon-eks.s3-us-west-2.amazonaws.com/1.12.7/2019-03-27/bin/linux/amd64/aws-iam-authenticator
chmod +x aws-iam-authenticator && mv /usr/local/bin
# get  kubeconfig from EKS
aws eks update-kubeconfig --name test-eks-cluster  --region us-east-1 --kubeconfig ~/test-kubeconfig
export KUBECONFIG=~/test-kubeconfig
#test connection
kubectl get ns

