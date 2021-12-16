IP="7.7.7.5/32"
SG_ID1="sg-079452c1fb408ef50"
SG_ID2="sg-01b2050e756663597"
WAF_ID="6fabdaea-ff18-4b80-ab2e-e5171ee0dcf0"
WAF_NAME="testip"

# 特定のWAFにあるIP一覧取得
IPs=$(aws wafv2 get-ip-set \
    --name $WAF_NAME \
    --scope REGIONAL \
    --region=ap-northeast-1 \
    --id $WAF_ID \
    --query "IPSet.Addresses" --output text)

read -r -p "一覧を表示しますか？ (y/N): " yn
case "$yn" in
    [yY]*) echo $IPs | xargs -n1;;
    *)  ;;
esac

read -r -p $IP"の検索を開始しますか？ (y/N): " yn
case "$yn" in
    [yY]*) echo "処理を開始します.";;
    *) echo "処理を終了します." ; exit ;;
esac

if [[ `echo $IPs | grep $IP` ]] ; then
    echo 'ありました'
    echo '処理を終了します.'
    exit
fi

echo 'ありませんでした'

read -r -p "IPを登録しますか？ (y/N): " yn
case "$yn" in
    [yY]*) echo "処理を開始します.";;
    *) echo "処理を終了します." ; exit ;;
esac

# 以下IP登録処理
LOCK_TOKEN=$(aws wafv2 get-ip-set \
    --name $WAF_NAME \
    --scope REGIONAL \
    --region=ap-northeast-1 \
    --id $WAF_ID \
    --query "LockToken" --output text)

# IP更新
aws wafv2 update-ip-set \
    --name $WAF_NAME \
    --scope REGIONAL \
    --id $WAF_ID \
    --addresses $IP $IPs \
    --lock-token $LOCK_TOKEN

echo '更新終了しました.'

# 確認用にIP一覧取得
NEW_IPs=$(aws wafv2 get-ip-set \
    --name $WAF_NAME \
    --scope REGIONAL \
    --region=ap-northeast-1 \
    --id $WAF_ID \
    --query "IPSet.Addresses" --output text)

read -r -p "確認のため一覧を表示しますか？ (y/N): " yn
case "$yn" in
    [yY]*) echo $NEW_IPs | xargs -n1;;
    *)  "処理を終了します." ; exit ;;
esac

echo '処理を終了します.'
