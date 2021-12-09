# SGにIP登録。/があろうとなかろうと場合分けで登録できる

# 変数格納
IP=("5.5.5.5/32" "6.6.6.6/32" "7.7.7.7" "8.8.8.8/32" "9.9.9.9")
DESCRIPTION=("go" "roku" "nana" "hati" "kyu")
SG_ID1="sg-079452c1fb408ef50"
SG_ID2="sg-01b2050e756663597"

for (( i=0; i < ${#IP[*]}; i++ )); do
    if [ `echo ${IP[$i]} | grep '/'` ]; then
        aws ec2 authorize-security-group-ingress \
        --group-id $SG_ID1 \
        --ip-permissions IpProtocol=tcp,FromPort=3389,ToPort=3389,IpRanges="[{CidrIp=${IP[$i]},Description="${DESCRIPTION[$i]}"}]"
        
        aws ec2 authorize-security-group-ingress \
        --group-id $SG_ID2 \
        --ip-permissions IpProtocol=tcp,FromPort=443,ToPort=443,IpRanges="[{CidrIp=${IP[$i]},Description="${DESCRIPTION[$i]}"}]"
        
    else
        aws ec2 authorize-security-group-ingress \
        --group-id $SG_ID1 \
        --ip-permissions IpProtocol=tcp,FromPort=3389,ToPort=3389,IpRanges="[{CidrIp=${IP[$i]}/32,Description="${DESCRIPTION[$i]}"}]"
        
        aws ec2 authorize-security-group-ingress \
        --group-id $SG_ID2 \
        --ip-permissions IpProtocol=tcp,FromPort=443,ToPort=443,IpRanges="[{CidrIp=${IP[$i]}/32,Description="${DESCRIPTION[$i]}"}]"
    fi
done
