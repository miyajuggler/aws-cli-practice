#!/bin/bash
set -euo pipefail

IP="7.7.7.7/32"
SG_ID1="sg-079452c1fb408ef50"
SG_ID2="sg-01b2050e756663597"
WAF_ID="6fabdaea-ff18-4b80-ab2e-e5171ee0dcf0"

IPs=$(aws ec2 describe-security-groups \
    --group-ids $SG_ID1 \
    --query "SecurityGroups[*].IpPermissions[*]" --output text)

# portとIPの同時検索をしたいがそれには、配列を操作してportsとIPが同じ列にあってほしい。
# まだその技術がないため、また今度にする。
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
  exit
fi
