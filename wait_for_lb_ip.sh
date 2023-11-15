#!/bin/bash

# Wait for the Load Balancer's public IP to be available
lb_public_ip=""
retries=0
max_retries=30
while [ -z "$lb_public_ip" ]; do
    lb_public_ip=$(~/kubectl get services -n dev -o=jsonpath='{"{.items[0].status.loadBalancer.ingress[0].hostname}"}')
    [ -z "$lb_public_ip" ] && sleep 10 && retries=$((retries+1))
    [ "$retries" -ge "$max_retries" ] && echo "Error: Load Balancer IP not available after $max_retries retries" && exit 1
done

# Print the Load Balancer IP
echo "Load Balancer IP: $lb_public_ip"
