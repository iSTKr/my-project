#!/bin/env bash

kubectl apply -f redis-leader-deployment.yaml
kubectl apply -f redis-leader-service.yaml
kubectl apply -f frontend-local-deployment.yaml
kubectl apply -f frontend-service.yaml
sleep 10
kubectl port-forward svc/frontend 8080:80 &
kubectl get all