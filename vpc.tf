#                     _    __ 
#                    | |  / _|
#  __   ___ __   ___ | |_| |_ 
#  \ \ / / '_ \ / __|| __|  _|
#   \ V /| |_) | (__ | |_| |  
#    \_/ | .__/ \___(_)__|_|  
#        | |                  
#        |_|                  

#===================#
# Main VPC Resource #
#===================#

resource "aws_vpc" "main_vpc" {
  cidr_block            = var.vpc_cidr
  enable_dns_support    = "true"
  enable_dns_hostnames  = "true"
  instance_tenancy      = "default"


  tags = {
    Name = "${local.name_prefix}_vpc"
    Environment = var.env
  }
}

#=============================#
# Internet Gateway Resource   #
#=============================#
resource "aws_internet_gateway" "main_igw" {

  vpc_id   = aws_vpc.main_vpc.id
  
depends_on = [aws_vpc.main_vpc]

  tags = {
    Name = "${local.name_prefix}-igw"
  }
}


#==================#
# Subnet Resources #
#==================#

module "subnet_addrs" {
  source = "hashicorp/subnets/cidr"

  for_each = var.availability_zones

  

  base_cidr_block = var.vpc_cidr
  networks = [
    {
      name     = "${local.name_prefix}-${each.key}-app-sn"
      # 5 new bits creates a /28
      new_bits = 5
    },
    {
      name     = "${local.name_prefix}-${each.key}-secure-sn"
      # 5 new bits creates a /28
      new_bits = 5
    },
  ]
}

#============#
# App Subnet #
#============#

resource "aws_subnet" "app_sn" {
for_each = module.subnet_addrs.network_cidr_blocks

  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = each.key
  depends_on        = [aws_vpc.main_vpc]
  availability_zone = each.value

  tags = {
    Name = each.key
  }
}

#================#
# Secure Subnet  #
#================#

resource "aws_subnet" "secure_sn" {
for_each = module.subnet_addrs.network_cidr_blocks

  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = each.key
  depends_on        = [aws_vpc.main_vpc]
  availability_zone = each.value

  tags = {
    Name = each.key
  }
}

