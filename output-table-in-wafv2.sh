#!/bin/bash
set -euo pipefail

WAF_ID="6fabdaea-ff18-4b80-ab2e-e5171ee0dcf0"
WAF_NAME="testip"

aws wafv2 get-ip-set \
    --name $WAF_NAME \
    --scope REGIONAL \
    --region=ap-northeast-1 \
    --id $WAF_ID \
    --query '{
    Name:IPSet.Name,
    Id:IPSet.Id,
    Addresses:IPSet.Addresses
}' \
    --output table
