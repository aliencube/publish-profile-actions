#!/bin/sh -l

set -e

# List of args
# $1: Web/Functions App Indicator
# $2: Resource Group Name
# $3: Web/Function App Instance Name

clientId=$(echo $AZURE_CREDENTIALS | jq -r '.clientId')
clientSecret=$(echo $AZURE_CREDENTIALS | jq -r '.clientSecret')
subscriptionId=$(echo $AZURE_CREDENTIALS | jq -r '.subscriptionId')
tenantId=$(echo $AZURE_CREDENTIALS | jq -r '.tenantId')

az login --service-principal -u $clientId -p $clientSecret --tenant $tenantId

ifa=$(echo "$1" | tr '[:upper:]' '[:lower:]')

if [ "$ifa" -eq "true" ]
then
    profile=$(az functionapp deployment list-publishing-profiles -g $2 -n $3 --xml)
else
    profile=$(az webapp deployment list-publishing-profiles -g $2 -n $3 --xml)
fi

profile=$(echo $profile | sed -e 's|\"<|<|g' | sed -e 's|>\"|>|g' | sed -e 's|\\"|"|g' | sed -e 's|\\\\|\\|g')

echo "Profile: $profile"
echo "::set-output name=profile::'$profile'"
