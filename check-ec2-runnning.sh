#!/bin/bash
set -euo pipefail

# インスタンスが起動しているのかどうかチェック
# []でも[*]でもどちらでも大丈夫
aws ec2 describe-instances \
    --query "Reservations[].Instances[].{
    Name:Tags[?Key==\`Name\`]|[0].Value,
    Id:InstanceId,
    Status:State.Name
}" \
    --output table
