# 直書きパターン
# VPC作成
aws ec2 create-vpc \
    --cidr-block 10.0.0.0/16 \
    --instance-tenancy default \
    --tag-specifications "ResourceType=vpc,Tags=[{Key=Name,Value=cloud01-vpc}]"

# InternetGateway作成
aws ec2 create-internet-gateway \
    --tag-specifications "ResourceType=internet-gateway,Tags=[{Key=Name,Value=cloud01-igw}]"

aws ec2 attach-internet-gateway \
    --internet-gateway-id igw-088681d1f7a4e84c2 \
    --vpc-id vpc-0270f0de84d39ea6d

# Public subnet作成
aws ec2 create-subnet \
    --cidr-block 10.0.11.0/24 \
    --vpc-id vpc-0270f0de84d39ea6d \
    --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=cloud01-public-subnet-1a}]" \
    --availability-zone ap-northeast-1a

aws ec2 create-subnet \
    --cidr-block 10.0.12.0/24 \
    --vpc-id vpc-0270f0de84d39ea6d \
    --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=cloud01-public-subnet-1c}]" \
    --availability-zone ap-northeast-1c

# Public route table作成
aws ec2 create-route-table \
    --vpc-id vpc-0270f0de84d39ea6d \
    --tag-specifications "ResourceType=route-table,Tags=[{Key=Name,Value=cloud01-public-subnet-route}]"

aws ec2 create-route \
    --route-table-id rtb-0fa4d50af17f64d6a \
    --destination-cidr-block 0.0.0.0/0 \
    --gateway-id igw-088681d1f7a4e84c2

# 関連付け
aws ec2 associate-route-table \
    --route-table-id rtb-0fa4d50af17f64d6a \
    --subnet-id subnet-0a7cff658dfba9fa1

aws ec2 associate-route-table \
    --route-table-id rtb-0fa4d50af17f64d6a \
    --subnet-id subnet-0ad6f960cfdab4e3f


# 単一の値を取得する方法
aws ec2 describe-vpcs --filters Name=cidr,Values=10.0.0.0/16
aws ec2 describe-vpcs --query "Vpcs[*].VpcId"
aws ec2 describe-vpcs --output text
aws ec2 describe-vpcs --filters Name=cidr,Values=10.0.0.0/16 --query "Vpcs[*].VpcId" --output text
