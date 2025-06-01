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


#============#
# App Subnet #
#============#

resource "aws_subnet" "app_sn" {
for_each = var.availability_zones

  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 5, "${var.sn_incrementer + 1}")
  depends_on        = [aws_vpc.main_vpc]
  availability_zone = merge("${var.region}$"each.key)

  tags = {
    Name = "${local.name_prefix}_${each.key}-app-sn"
  }
}

#================#
# Secure Subnet  #
#================#

resource "aws_subnet" "secure_sn" {
for_each = var.availability_zones

  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 5, "${var.sn_incrementer + 1}")
  depends_on        = [aws_vpc.main_vpc]
  availability_zone = merge("${var.region}$"each.key)

  tags = {
    Name = "${local.name_prefix}_${each.key}-secure-sn"
  }
}

