#!/bin/bash
# Install Treafik 
helm repo add traefik https://traefik.github.io/charts
helm repo update
helm install traefik traefik/traefik

# we need to work with NodePort in killercoda
kubectl delete services traefik
kubectl delete deployment traefik
# Create the environment Kubernetes
kubectl apply -f solution.yaml 
HOSTNAME_TO_ADD="jobs.your.cluster.local"
HOSTS_FILE="/etc/hosts"

NODE_IP=$(kubectl get nodes -o jsonpath='{.items[?(@.metadata.name=="controlplane")].status.addresses[?(@.type=="InternalIP")].address}')
NEW_HOST_ENTRY="${NODE_IP} ${HOSTNAME_TO_ADD}"
# Add the line to /etc/hosts
echo "$NEW_HOST_ENTRY" >> /etc/hosts
echo "Added '${NEW_HOST_ENTRY}' to /etc/hosts for custom domain name"
sudo systemctl restart NetworkManager

#reset the pod for get the new configuration 
REMOVE_PODS_TRAEFIK=$(kubectl get pods -l app=traefik -o jsonpath='{.items[0].metadata.name}')
REMOVE_PODS_TRAEFIK_JOB=$(kubectl get pods -l  app.kubernetes.io/instance=traefik-default,app.kubernetes.io/name=traefik -o jsonpath='{.items[0].metadata.name}')
kubectl delete pod $REMOVE_PODS_TRAEFIK
kubectl delete pod $REMOVE_PODS_TRAEFIK_JOB

# Check if any NodePorts were found
NODE_PORTS=($(kubectl get service traefik -o jsonpath='{.spec.ports[*].nodePort}'))
if [ ${#NODE_PORTS[@]} -eq 0 ]; then
    echo "Error: No NodePorts found for 'traefik' service. Exiting."
    exit 1
fi

echo "Found NodePorts: ${NODE_PORTS[@]}"
echo "--- Starting curl requests ---"
PROTOCOL=http
# --- Loop through each NodePort and perform curl ---
for port in "${NODE_PORTS[@]}"; do
    TARGET_URL="${PROTOCOL}://${HOSTNAME_TO_ADD}:${port}/" # You can change "/" to "/tls", "/notls", etc.
    echo "Curling ${TARGET_URL}..."
    curl -sS "${TARGET_URL}"
    echo "" # Add a newline for readability after each curl output
    echo "---"
done
