#!/bin/bash
set -euo pipefail

# インスタンスが起動しているのかどうかチェック
# []でも[*]でもどちらでも大丈夫
# Name:Tags[?Key==\`Name\`]|[0].Value ここでtagのKeyがNameになっているものだけを取得。
# 階層が違うので|[0]で下に持ってこれる。
aws ec2 describe-instances \
    --query "Reservations[].Instances[].{
    Name:Tags[?Key==\`Name\`]|[0].Value,
    Id:InstanceId,
    Status:State.Name
}" \
    --output table
