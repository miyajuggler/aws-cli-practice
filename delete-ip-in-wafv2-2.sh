#!/bin/bash
set -euo pipefail

# wafにあるIPを一つ削除

WAF_ID="6fabdaea-ff18-4b80-ab2e-e5171ee0dcf0"
IP="7.7.7.5/32"
WAF_NAME="testip"

json=$(aws wafv2 get-ip-set \
    --name $WAF_NAME \
    --scope REGIONAL \
    --region=ap-northeast-1 \
    --id $WAF_ID)

IPs=$(echo $json | jq -r '.IPSet.Addresses[]')
LOCK_TOKEN=$(echo $json | jq -r '.LockToken')

NEW_IPs=$(echo ${IPs//${IP}/})

# IP更新
aws wafv2 update-ip-set \
    --name $WAF_NAME \
    --scope REGIONAL \
    --region=ap-northeast-1 \
    --id $WAF_ID \
    --addresses $NEW_IPs \
    --lock-token $LOCK_TOKEN
