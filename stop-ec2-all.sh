#!/bin/bash
set -euo pipefail

# インスタンス全停止
# join(" ")で配列とダブルクォートを消してくっつけているが、そもそも以下でよし
# | jq -r '[.Reservations[].Instances[] | select(.State.Name == "running") | .InstanceId
aws ec2 stop-instances --instance-ids $(aws ec2 describe-instances \
| jq -r '[.Reservations[].Instances[] | select(.State.Name == "running") | .InstanceId] | join(" ")')
