#!/bin/bash

kubectl apply -f postgres-deployment.yaml
kubectl apply -f postgres-service.yaml
kubectl apply -f go-app-deployment.yaml
kubectl apply -f go-app-service.yaml
kubectl apply -f go-app-ingress.yaml