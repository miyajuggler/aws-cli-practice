#!/bin/bash
set -euo pipefail

# インスタンスが起動しているのかどうかチェックjqコマンドバージョン
# 構造はかなり似ている。 -cで
aws ec2 describe-instances \
| jq -c '.Reservations[].Instances[] | {Name: .Tags[] | select(.Key == "Name").Value, Id: .InstanceId, State: .State.Name}'
