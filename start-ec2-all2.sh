#!/bin/bash
set -euo pipefail

# 停止しているインスタンスをすべて起動。
$ aws ec2 describe-instances \
    | jq -r '.Reservations[].Instances[] | select(.State.Name == "stopped") | [ .InstanceId, (.Tags[]? | select(.Key == "Name")).Value ] | @sh' \
    | awk '{ print "echo Instance Starting... " $1 " " $2 "; aws ec2 start-instances --instance-ids " $1 }' | sh
