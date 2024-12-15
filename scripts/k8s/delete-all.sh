#!/bin/bash

kubectl delete deploy postgres
kubectl delete service postgres-service
kubectl delete deploy go-app
kubectl delete service go-app-service
kubectl delete ingress go-app-ingress