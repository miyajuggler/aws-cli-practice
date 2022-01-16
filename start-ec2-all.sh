#!/bin/bash
set -euo pipefail

# 停止しているインスタンスをすべて起動
# join(" ")で配列とダブルクォートを消してくっつけているが、そもそも以下でよし
# | jq -r '[.Reservations[].Instances[] | select(.State.Name == "stopped") | .InstanceId
aws ec2 start-instances --instance-ids $(aws ec2 describe-instances \
| jq -r '[.Reservations[].Instances[] | select(.State.Name == "stopped") | .InstanceId] | join(" ")')
