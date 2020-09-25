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

login=$(az login --service-principal -u $clientId -p $clientSecret --tenant $tenantId)

ifa=$(echo "$1" | tr '[:upper:]' '[:lower:]')

if [ "$ifa" -eq "true" ]
then
    profile=$(az functionapp deployment list-publishing-profiles -g $2 -n $3 --xml --output tsv)
else
    profile=$(az webapp deployment list-publishing-profiles -g $2 -n $3 --xml --output tsv)
fi

echo "::set-output name=profile::'$profile'"
