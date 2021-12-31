SG_ID="sg-01b2050e756663597"

aws ec2 describe-security-groups \
    --group-ids $SG_ID \
    --query 'SecurityGroups[*].IpPermissions[*].{
    FromPort:FromPort,
    Ip:IpRanges[*]
}' \
    --output table
