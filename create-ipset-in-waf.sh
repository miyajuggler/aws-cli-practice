#!/bin/bash
set -euo pipefail

# 東京リージョンで作成パターン
aws wafv2 create-ip-set \
    --name testip \
    --scope REGIONAL \
    --region=ap-northeast-1 \
    --description testtest \
    --ip-address-version IPV4 \
    --addresses 100.100.100.0/32

# cloudfrontで作成パターン
aws wafv2 create-ip-set \
    --name testip3 \
    -scope CLOUDFRONT \
    --region=us-east-1 \
    --description testtest \
    --ip-address-version IPV4 \
    --addresses 100.100.100.0/32

# WAF作成&IP登録。region指定しなくても勝手に東京リージョンになった。謎
aws wafv2 create-ip-set \
    --name testip \
    --scope REGIONAL \
    --description testtest \
    --ip-address-version IPV4 \
    --addresses 10.10.10.10/32
