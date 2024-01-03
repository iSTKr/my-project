#!/bin/env bash

kubectl delete deployment frontend redis-leader
kubectl delete service frontend redis-leader
sleep 10
kubectl get all