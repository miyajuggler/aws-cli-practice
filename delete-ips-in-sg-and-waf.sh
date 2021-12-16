# SGとWAFにあるIPを複数削除

IP_ARRAY=("5.5.5.5/32" "6.6.6.6/32" "7.7.7.7/32" "8.8.8.8/32" "9.9.9.9/32")
SG_ID1="sg-079452c1fb408ef50"
SG_ID2="sg-01b2050e756663597"
WAF_ID="6fabdaea-ff18-4b80-ab2e-e5171ee0dcf0"
WAF_NAME="testip"

for (( i=0; i < ${#IP_ARRAY[*]}; i++ )); do
    aws ec2 revoke-security-group-ingress \
        --group-id $SG_ID1 \
        --protocol tcp \
        --port 3389 \
        --cidr ${IP_ARRAY[$i]}

    aws ec2 revoke-security-group-ingress \
        --group-id $SG_ID2 \
        --protocol tcp \
        --port 443 \
        --cidr ${IP_ARRAY[$i]}

    # 現在登録されているIPを取得
    json=$(aws wafv2 get-ip-set \
        --name $WAF_NAME \
        --scope REGIONAL \
        --region=ap-northeast-1 \
        --id $WAF_ID)

    IPs=$(echo $json | jq -r '.IPSet.Addresses[]')
    LOCK_TOKEN=$(echo $json | jq -r '.LockToken')

    # リストから指定のIPを省く
    NEW_IPs=$(echo ${IPs//${IP_ARRAY[$i]}/})

    # IP更新
    aws wafv2 update-ip-set \
        --name $WAF_NAME \
        --scope REGIONAL \
        --id $WAF_ID \
        --addresses $NEW_IPs \
        --lock-token $LOCK_TOKEN

done
