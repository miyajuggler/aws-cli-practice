#!/bin/bash
set -euo pipefail

# インスタンス全停止
aws ec2 stop-instances --instance-ids $(aws ec2 describe-instances \
| jq -r '[.Reservations[].Instances[] | select(.State.Name == "running") | .InstanceId] | join(" ")')
