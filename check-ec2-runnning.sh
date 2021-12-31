#!/bin/bash
set -euo pipefail

# インスタンスが起動しているのかどうかチェック
# []でも[*]でもどちらでも大丈夫
aws ec2 describe-instances \
    --query 'Reservations[*].Instances[*].{
    InstanceId:InstanceId,
    Name:State.Name
}' \
    --output table
