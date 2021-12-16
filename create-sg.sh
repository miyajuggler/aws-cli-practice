#!/bin/bash
set -euo pipefail

# SGを作成
aws ec2 create-security-group \
    --description testtest \
    --group-name test-sg \
    --vpc-id vpc-7979bd1f \
    --tag-specifications "ResourceType=security-group,Tags=[{Key=Name,Value=test-sg}]"
