# SGにあるIPを一つ指定して削除
SG_ID1="sg-079452c1fb408ef50"
IP="8.8.8.8/32"

aws ec2 revoke-security-group-ingress \
    --group-id $SG_ID1 \
    --protocol tcp \
    --port 3389 \
    --cidr $IP
