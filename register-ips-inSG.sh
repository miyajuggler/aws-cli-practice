# SGにIP登録。配列ver

# 変数格納
IP=("5.5.5.5/32" "6.6.6.6/32" "7.7.7.7/32" "8.8.8.8/32" "9.9.9.9/32")
DESCRIPTION=("go" "roku" "nana" "hati" "kyu")

for (( i=0; i < ${#IP[*]}; i++ )); do
  aws ec2 authorize-security-group-ingress \
    --group-id sg-0e723de10ea0b87dc \
    --ip-permissions IpProtocol=tcp,FromPort=3389,ToPort=3389,IpRanges="[{CidrIp=${IP[$i]},Description="${DESCRIPTION[$i]}"}]"
done
