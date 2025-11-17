#!/bin/bash
set -e

echo "============================================" 
echo "==== Starting Production Cluster Update ===="
echo "============================================" 

# Get all deployments in production namespace with specific labels
DEPLOYMENTS=$(kubectl get deployments -n production --selector=workload=production -o jsonpath='{.items[*].metadata.name}')

if [ -z "$DEPLOYMENTS" ]; then
    echo "No deployments found with labels: workload=production"
    exit 1
fi

# Update each deployment
for DEPLOYMENT in $DEPLOYMENTS; do
    echo "-------------------------------------"
    echo "Updating: $DEPLOYMENT"
    
    # Get current image
    CURRENT_IMAGE=$(kubectl get deployment/$DEPLOYMENT -n production -o jsonpath='{.spec.template.spec.containers[0].image}')
    echo "Current image: $CURRENT_IMAGE"
    
    # Trigger rollout restart (this will pull the latest image with the same tag)
    kubectl rollout restart deployment/$DEPLOYMENT -n production
    
    # Wait for rollout to complete
    kubectl rollout status deployment/$DEPLOYMENT -n production --timeout=300s
    
    # Get new image after rollout
    NEW_IMAGE=$(kubectl get deployment/$DEPLOYMENT -n production -o jsonpath='{.spec.template.spec.containers[0].image}')
    echo "Updated: $DEPLOYMENT @ New image: $NEW_IMAGE"
    echo "-------------------------------------"
done

# Final status
echo "Final deployment status:"
kubectl get deployments -n production --selector=workload=production -o wide

echo "============================================" 
echo "==== Ending Production Cluster Update ======"
echo "============================================" 
