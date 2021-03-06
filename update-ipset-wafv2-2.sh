# 作成したwafipsetのIDを格納
#!/bin/bash
set -euo pipefail

ID="6fabdaea-ff18-4b80-ab2e-e5171ee0dcf0"
# 配列はコンマすらつけずこの書き方でよし
IP="1.1.1.1/32 2.2.2.2/32 3.3.3.3/32 4.4.4.4/32 5.5.5.5/32"
WAF_NAME="testip"

# 現在登録されているIPを取得
json=$(aws wafv2 get-ip-set \
    --name $WAF_NAME \
    --scope REGIONAL \
    --region=ap-northeast-1 \
    --id $ID)

# jqを使ってIPとトークンを取得。jqコマンドは初期状態では使えないため以下コマンドでインストール必須
# sudo yum -y install jq
IPs=$(echo $json | jq -r '.IPSet.Addresses[]')
LOCK_TOKEN=$(echo $json | jq -r '.LockToken')

# IP更新
aws wafv2 update-ip-set \
    --name $WAF_NAME \
    --scope REGIONAL \
    --region=ap-northeast-1 \
    --id $ID \
    --addresses $IP $IPs \
    --lock-token $LOCK_TOKEN
