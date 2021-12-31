SG_ID="sg-01b2050e756663597"

JSON=$(aws ec2 describe-security-groups \
    --group-ids $SG_ID \
    --query "SecurityGroups[0].IpPermissions")

aws ec2 revoke-security-group-ingress --cli-input-json "{\"GroupId\": \"$SG_ID\", \"IpPermissions\": $JSON}"
