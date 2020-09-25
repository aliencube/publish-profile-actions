#!/bin/bash

set -e

# List of args
# $1: Web/Functions App Indicator
# $2: Resource Group Name
# $3: Web/Function App Instance Name

ifa=$("$1" | tr '[:upper:]' '[:lower:]')

if [ "$ifa" -eq "true" ]
then
    profile=$(az functionapp deployment list-publishing-profiles -g $2 -n $3 --xml)
else
    profile=$(az webapp deployment list-publishing-profiles -g $2 -n $3 --xml)
fi

echo "Profile: $profile"

echo "::set-output name=profile::'$profile'"
