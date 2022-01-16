#!/bin/bash
set -euo pipefail

# 停止しているインスタンスをすべて起動
aws ec2 start-instances --instance-ids $(aws ec2 describe-instances \
| jq -r '[.Reservations[].Instances[] | select(.State.Name == "stopped") | .InstanceId] | join(" ")')
