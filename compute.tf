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
for_each = var.availability_zones

  subnet_id         = aws_subnet.app_sn[each.key].id
  security_groups   = [aws_security_group.web_servers_sg.name]

  attachment {
    instance     = aws_instance.web_server[each.key].id
    device_index = 1
  }
}

#======================#
# Web Server Instances #
#======================#
resource "aws_instance" "web_server" {
for_each = var.availability_zones

    ami                      = data.aws_ami.amazon-linux-2.id
    instance_type            = var.instance_type
    security_groups          = [aws_security_group.web_servers_sg.name]
    subnet_id                = aws_subnet."${local.name_prefix}-${each.key}-app-sn".id
    user_data                = file("bootstrap.sh")
    availability_zone        = each.value

  tags = {
    Name = "${local.name_prefix}_${each.key}_web"
  }

}

