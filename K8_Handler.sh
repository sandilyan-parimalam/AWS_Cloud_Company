#!/bin/bash

if [ "${ACTION}" == "Default_Apply" ] || [ "${ACTION}" == "apply" ]; then
    is_cluster_alive=$(~/kubectl get nodes 2>/dev/null)
    if [ "${is_cluster_alive}" ]; then
        echo "Cluster is alive. Applying deployment..."

        ~/kubectl apply -n dev -f K8_Manifests/Dev_Web_Manifest.yaml

        # Wait for all external IPs of LoadBalancer services
        max_retries=30
        retries=0
        lb_ips=""
        NS=$(cat K8_Manifests/Dev_Web_Manifest.yaml  | grep "namespace :" | cut -d ":" f2)
        until [ ${retries} -ge ${max_retries} ]; do
            echo "Try ${retries} out of ${max_retries} - Waiting for LB to get FDQN from ${NS}..."
            lb_ips=$(/var/lib/jenkins/kubectl get -n ${NS} services -o jsonpath='{.items[?(@.spec.type=="LoadBalancer")].status.loadBalancer.ingress[*].hostname}')
            [ -n "${lb_ips}" ] && break
            retries=$((retries + 1))
            sleep 10
        done

        if [ -n "${lb_ips}" ]; then
            echo "LoadBalancer external IPs: ${lb_ips}"
        else
            echo "Error: LoadBalancer IPs not available after ${max_retries} retries."
            exit 1
        fi
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
