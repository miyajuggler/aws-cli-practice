# wafにあるIPを一つ削除

ID="6fabdaea-ff18-4b80-ab2e-e5171ee0dcf0"
IP="2.2.2.2/32"
WAF_NAME="testip"

# 現在登録されているIPを取得
IPs=$(aws wafv2 get-ip-set \
    --name $WAF_NAME \
    --scope REGIONAL \
    --id $ID \
    --query "IPSet.Addresses[*]" --output text)

LOCK_TOKEN=$(aws wafv2 get-ip-set \
    --name $WAF_NAME \
    --scope REGIONAL \
    --region=ap-northeast-1 \
    --id $ID \
    --query "LockToken" --output text)

NEW_IPs=$(echo ${IPs//${IP}/})

# IP更新
aws wafv2 update-ip-set \
    --name $WAF_NAME \
    --scope REGIONAL \
    --id $ID \
    --addresses $NEW_IPs \
    --lock-token $LOCK_TOKEN
