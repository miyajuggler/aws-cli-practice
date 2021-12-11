# SGにIP登録。配列ver
#!/bin/bash
set -euo pipefail

# 変数格納
IP_ARRAY=("5.5.5.5/32" "6.6.6.6/32" "7.7.7.7" "8.8.8.8/32" "9.9.9.9")
DESCRIPTION=("go" "roku" "nana" "hati" "kyu")
SG_ID1="sg-079452c1fb408ef50"
SG_ID2="sg-01b2050e756663597"
WAF_ID="6fabdaea-ff18-4b80-ab2e-e5171ee0dcf0"
WAF_NAME="testip"

for (( i=0; i < ${#IP_ARRAY[*]}; i++ )); do
    if [ `echo ${IP_ARRAY[$i]} | grep '/'` ]; then
        aws ec2 authorize-security-group-ingress \
            --group-id $SG_ID1 \
            --ip-permissions IpProtocol=tcp,FromPort=3389,ToPort=3389,IpRanges="[{CidrIp=${IP_ARRAY[$i]},Description="${DESCRIPTION[$i]}"}]"

        aws ec2 authorize-security-group-ingress \
            --group-id $SG_ID2 \
            --ip-permissions IpProtocol=tcp,FromPort=443,ToPort=443,IpRanges="[{CidrIp=${IP_ARRAY[$i]},Description="${DESCRIPTION[$i]}"}]"

        json=$(aws wafv2 get-ip-set \
            --name $WAF_NAME \
            --scope REGIONAL \
            --region=ap-northeast-1 \
            --id $WAF_ID)

        IPs=$(echo $json | jq -r '.IPSet.Addresses[]')
        LOCK_TOKEN=$(echo $json | jq -r '.LockToken')

        # IP更新
        aws wafv2 update-ip-set \
            --name $WAF_NAME \
            --scope REGIONAL \
            --region=ap-northeast-1 \
            --id $WAF_ID \
            --addresses $IPs ${IP_ARRAY[$i]} \
            --lock-token $LOCK_TOKEN

    else
        aws ec2 authorize-security-group-ingress \
            --group-id $SG_ID1 \
            --ip-permissions IpProtocol=tcp,FromPort=3389,ToPort=3389,IpRanges="[{CidrIp=${IP_ARRAY[$i]}/32,Description="${DESCRIPTION[$i]}"}]"

        aws ec2 authorize-security-group-ingress \
            --group-id $SG_ID2 \
            --ip-permissions IpProtocol=tcp,FromPort=443,ToPort=443,IpRanges="[{CidrIp=${IP_ARRAY[$i]}/32,Description="${DESCRIPTION[$i]}"}]"

        json=$(aws wafv2 get-ip-set \
            --name $WAF_NAME \
            --scope REGIONAL \
            --region=ap-northeast-1 \
            --id $WAF_ID)

        IPs=$(echo $json | jq -r '.IPSet.Addresses[]')
        LOCK_TOKEN=$(echo $json | jq -r '.LockToken')

        # IP更新
        aws wafv2 update-ip-set \
            --name $WAF_NAME \
            --scope REGIONAL \
            --region=ap-northeast-1 \
            --id $WAF_ID \
            --addresses $IPs ${IP_ARRAY[$i]}/32 \
            --lock-token $LOCK_TOKEN
    fi
done
