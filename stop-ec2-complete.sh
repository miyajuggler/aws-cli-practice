#!/bin/bash
set -euo pipefail

# cloud9のインスタンス以外のインスタンスを全停止
aws ec2 stop-instances --instance-ids $(aws ec2 describe-instances \
| jq -r --arg myid $(curl http://169.254.169.254/latest/meta-data/instance-id 2> /dev/null) \
'[.Reservations[].Instances[] | select(.InstanceId != $myid) | select(.State.Name == "running") | .InstanceId] | join(" ")')
