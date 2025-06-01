#                                   _        _    __ 
#                                  | |      | |  / _|
#    ___ ___  _ __ ___  _ __  _   _| |_ ___ | |_| |_ 
#   / __/ _ \| '_ ` _ \| '_ \| | | | __/ _ \| __|  _|
#  | (_| (_) | | | | | | |_) | |_| | ||  __/| |_| |  
#   \___\___/|_| |_| |_| .__/ \__,_|\__\___(_)__|_|  
#                      | |                           
#                      |_|                           


data "aws_ami" "amazon-linux-2" {
 most_recent = true


 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }

 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}


#=======================================#
# Web Server Elastic Network Interfaces #
#=======================================#
resource "aws_network_interface" "web_server_eni" {

  count             = var.subnet_count
  subnet_id         = aws_subnet.app_sn[count.index].id
  security_groups   = [aws_security_group.web_servers_sg.name]

  attachment {
    instance     = aws_instance.web_server[count.index].id
    device_index = 1
  }
}

#======================#
# Web Server Instances #
#======================#
resource "aws_instance" "web_server" {

    count                    = var.subnet_count
    ami                      = data.aws_ami.amazon-linux-2.id
    instance_type            = var.instance_type
    security_groups          = [aws_security_group.web_servers_sg.name]
    subnet_id                = aws_subnet.app_sn[count.index].id
    user_data                = file("bootstrap.sh")
    availability_zone        = count.index

  tags = {
    Name = "${local.name_prefix}_${count.index}_web"
  }

}

