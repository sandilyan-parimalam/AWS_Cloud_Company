#!/bin/bash

# Load variables
source ./dev_varriables.tf
source ./modules/vpc/variables.tf

manifest_file="K8_Manifests/Dev_Web_Manifest.yaml"

if [ ! -f ${manifest_file} ]; then
    echo "Error: Unable to find the ${manifest_file}, please check.."
    exit 1
fi

NS=$(cat ${manifest_file} | grep "namespace:" | head -1 | cut -d ":" -f2)

if [ -z "${NS}" ]; then
    echo "Error: Unable to get the namespace from the manifest, Please check"
    exit 1
fi

if [ "${ACTION}" == "Default_Apply" ] || [ "${ACTION}" == "apply" ]; then
    is_cluster_alive=$(~/kubectl get nodes 2>/dev/null)
    if [ "${is_cluster_alive}" ]; then
        echo "Cluster is alive. Applying deployment..."
        if [ ! -f ${manifest_file} ]; then
            echo "Error: Unable to find the ${manifest_file}, please check.."
            exit 1
        fi
        ~/kubectl apply -n ${NS} -f ${manifest_file}

        # Wait for all external IPs of LoadBalancer services
        max_retries=30
        retries=0
        lb_ips=""
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
    # Check if the cluster is alive
    is_cluster_alive=$(kubectl get nodes 2>/dev/null)

    if [ -n "${is_cluster_alive}" ]; then
        echo "Cluster is alive. Deleting deployment in namespace ${NS}..."
        # Attempt to delete the deployment
        if kubectl delete -n "${NS}" -f "${manifest_file}"; then
            echo "Deployment deleted successfully."

            # Detach network interfaces associated with the VPC
            vpc_id=$(aws ec2 describe-vpcs --region ${region} --filters "Name=tag:Name,Values=${vpc_name}" --query "Vpcs[*].VpcId" --output text)

            if [ -n "${vpc_id}" ]; then
                echo "VPC ID: ${vpc_id}"

                ni_ids=$(aws ec2 describe-network-interfaces --region ${region} --filters "Name=vpc-id,Values=${vpc_id}" --query "NetworkInterfaces[*].NetworkInterfaceId" --output text)

                for ni_id in ${ni_ids}; do
                    aws ec2 detach-network-interface --region ${region} --network-interface-id "${ni_id}"
                    echo "Detached network interface: ${ni_id}"
                done
            else
                echo "Error: VPC ID not found. Please check your VPC configuration."
            fi
        else
            echo "Failed to delete deployment. Check the error message for details."
            exit 1
        fi
    else
        echo "Cluster is not available, skipping deployment deletion"
    fi
fi
