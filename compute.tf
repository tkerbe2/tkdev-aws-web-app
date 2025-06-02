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

#======================#
# Web Server Instances #
#======================#
resource "aws_instance" "web_server" {

    count                       = length(var.availability_zones)
    ami                         = data.aws_ami.amazon-linux-2.id
    instance_type               = var.instance_type
    security_groups             = [aws_security_group.web_servers_sg.id]
    subnet_id                   = aws_subnet.app_sn[count.index].id
    user_data                   = file("bootstrap.sh")
    availability_zone           = var.availability_zones[count.index]
    associate_public_ip_address = true
    key_name                    = var.ssh_key_pair

  tags = {
    Name = "${local.name_prefix}-${count.index}-web"
  }

}

