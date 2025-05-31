#              _                      _     _    __ 
#             | |                    | |   | |  / _|
#   _ __   ___| |___      _____  _ __| | __| |_| |_ 
#  | '_ \ / _ \ __\ \ /\ / / _ \| '__| |/ /| __|  _|
#  | | | |  __/ |_ \ V  V / (_) | |  |   < | |_| |  
#  |_| |_|\___|\__| \_/\_/ \___/|_|  |_|\_(_)__|_|  
                                                  
                                                   
#=============================#
# Internet Gateway Resource   #
#=============================#
resource "aws_internet_gateway" "main_igw" {

  vpc_id   = aws_vpc.main_vpc.id
  
depends_on = [aws_vpc.main_vpc]

  tags = {
    Name = "${local.name_prefix}_igw"
  }
}
