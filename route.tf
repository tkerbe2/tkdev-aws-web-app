#                   _        _    __ 
#                  | |      | |  / _|
#   _ __ ___  _   _| |_ ___ | |_| |_ 
#  | '__/ _ \| | | | __/ _ \| __|  _|
#  | | | (_) | |_| | ||  __/| |_| |  
#  |_|  \___/ \__,_|\__\___(_)__|_|  
                                   

#=====================#
# Default Route Table #
#=====================#
resource "aws_default_route_table" "default_rt" {
  default_route_table_id = aws_vpc.main_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main_igw.id
    }
    

    tags = {
    Name = "${local.name_prefix}_main_rt"
  }
  
}
