#!/bin/bash
set -euo pipefail

# インスタンスが起動しているのかどうかチェックCSVバージョン
# 一番下のやつをするだけ。意味はわからん
# 前半の jq '.[]'で階層をひとつ上に持ってきている。
aws ec2 describe-instances \
    --query "Reservations[].Instances[].{
    Name:Tags[?Key==\`Name\`]|[0].Value,
    Id:InstanceId,
    State:State.Name
}" \
|  jq '.[]' | jq -rs '(.[0]|keys_unsorted),map([.[]])[]|@csv'
