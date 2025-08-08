#!/bin/bash

export NAMESPACE=stateful-java-poc

export CLUSTER_NAME=`kubectl config current-context`
export CLUSTER_DOMAIN=$CLUSTER_NAME.kat.cmmaz.cloud

# create namespace
kubectl create namespace $NAMESPACE

# install consoles-helm-chart
# we need to use our modified consoles-values-kubernetes.yaml file to remove ingressClassName from our ingress,
# since it is not supported in our Kat cluster
helm pull oci://quay.io/bamoe/consoles-helm-chart --version=9.2.1-ibm-0005 --untar
helm install \
    -n $NAMESPACE my-bamoe-consoles ./consoles-helm-chart \
    --values ./kubernetes/console-values-kubernetes.yaml \
    --set global.kubernetesClusterDomain="$CLUSTER_DOMAIN" \
    --set ingress.className=null 

# install postgresql
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install -n $NAMESPACE my-pg bitnami/postgresql 

# install canvas-helm-chart
# we need to use our modified canvas-values-kubernetes.yaml file to remove ingressClassName from our ingress,
# since it is not supported in our Kat cluster
helm pull oci://quay.io/bamoe/canvas-helm-chart --version=9.2.1-ibm-0005 --untar
helm install -n $NAMESPACE  my-bamoe-canvas ./canvas-helm-chart \
             --values ./kubernetes/canvas-values-kubernetes.yaml \
             --set global.kubernetesClusterDomain="$CLUSTER_DOMAIN"

# Install Prometheus Operator so we can deploy with kie-addons-quarkus-monitoring-prometheus
kubectl create -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/master/bundle.yaml

# export user to be used in maven deployments
USER=$(whoami)
export USER=${USER//./}
