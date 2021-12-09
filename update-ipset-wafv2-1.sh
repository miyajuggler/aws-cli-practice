# 作成したwafipsetのIDを格納
ID="6fabdaea-ff18-4b80-ab2e-e5171ee0dcf0"
# 配列はコンマすらつけずこの書き方でよし
IP="1.1.1.1/32 2.2.2.2/32 3.3.3.3/32 4.4.4.4/32 5.5.5.5/32"

# 現在登録されているIPとトークンをJMESPathを使って取得
IPs=$(aws wafv2 get-ip-set \
    --name testip \
    --scope REGIONAL \
    --id $ID \
    --query "IPSet.Addresses[*]" --output text)

LOCK_TOKEN=$(aws wafv2 get-ip-set \
    --name testip \
    --scope REGIONAL \
    --region=ap-northeast-1 \
    --id $ID \
    --query "LockToken" --output text)

# IP更新
aws wafv2 update-ip-set \
    --name testip \
    --scope REGIONAL \
    --region=ap-northeast-1 \
    --id $ID \
    --addresses $IP $IPs \
    --lock-token $LOCK_TOKEN
