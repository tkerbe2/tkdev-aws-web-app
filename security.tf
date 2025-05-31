#                            _ _          _    __ 
#                           (_) |        | |  / _|
#   ___  ___  ___ _   _ _ __ _| |_ _   _ | |_| |_ 
#  / __|/ _ \/ __| | | | '__| | __| | | || __|  _|
#  \__ \  __/ (__| |_| | |  | | |_| |_| || |_| |  
#  |___/\___|\___|\__,_|_|  |_|\__|\__, (_)__|_|  
#                                   __/ |         
#                                  |___/          


resource "aws_security_group" "web_servers_sg" {
  name        = "${local.name_prefix}_web_server_sg"
  description = "Allow HTTP and HTTPS traffic to web servers"
  vpc_id      = aws_vpc.main_vpc.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  tags = {
    Name = "${local.name_prefix}_web_server_sg"
  }

}

#==============================#
# Security Group Ingress Rules #
#==============================#
#These are all the rules necessary to allow our traffic inbound to our web servers
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.web_servers_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.web_servers_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.web_servers_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  to_port           = 22
}
