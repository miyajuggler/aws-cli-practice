#!/bin/bash
set -euo pipefail

# 一つだけSGにIP登録

aws ec2 authorize-security-group-ingress \
    --group-id sg-0e723de10ea0b87dc \
    --ip-permissions IpProtocol=tcp,FromPort=3389,ToPort=3389,IpRanges="[{CidrIp=203.0.116.0/32,Description="test"}]"
