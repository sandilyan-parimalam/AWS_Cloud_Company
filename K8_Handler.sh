#!/bin/bash

if [ "${ACTION}" = "apply" ]; then
    is_cluster_alive=$(~/kubectl get nodes 2>/dev/null)
    if [ "${is_cluster_alive}" ]; then
        echo "Cluster is alive. Applying deployment..."
        ~/kubectl apply -n dev -f K8_Manifests/Dev_Web_Manifest.yaml
    else
        echo "Error: Cluster is not available. Deployment not applied."
        exit 1
    fi
fi

if [ "${ACTION}" = "destroy" ]; then
    is_cluster_alive=$(~/kubectl get nodes 2>/dev/null)
    if [ "${is_cluster_alive}" ]; then
        echo "Cluster is alive. Deleting deployment..."
        ~/kubectl delete -n dev -f K8_Manifests/Dev_Web_Manifest.yaml
    else
        echo "Cluster is not available, skipping deployment deletion"
    fi
fi
