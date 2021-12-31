#!/bin/bash
set -euo pipefail

# 特定のインスタンス起動からのチェック
aws ec2 start-instances --instance-ids i-066b058a880601015 \
&& echo "-- Please wait until instance started..." \
&& aws ec2 wait instance-running --instance-ids i-066b058a880601015 \
&& aws ec2 describe-instance-status --instance-ids i-066b058a880601015 \
| jq '.InstanceStatuses[] | {InstanceId, InstanceState: .InstanceState.Name, SystemStatus: .SystemStatus.Status, InstanceStatus: .InstanceStatus.Status}'
