#!/bin/bash
set -euo pipefail

ID="i-066b058a880601015"

# 特定のインスタンス起動からのチェック
aws ec2 start-instances --instance-ids $ID \
&& echo "-- Please wait until instance started..." \
&& aws ec2 wait instance-running --instance-ids $ID \
&& aws ec2 describe-instance-status --instance-ids $ID \
| jq '.InstanceStatuses[] | {InstanceId, InstanceState: .InstanceState.Name, SystemStatus: .SystemStatus.Status, InstanceStatus: .InstanceStatus.Status}'
