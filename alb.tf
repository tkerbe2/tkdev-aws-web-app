
#   _                 _ _           _                           _    __ 
#  | | ___   __ _  __| | |__   __ _| | __ _ _ __   ___ ___ _ __| |_ / _|
#  | |/ _ \ / _` |/ _` | '_ \ / _` | |/ _` | '_ \ / __/ _ \ '__| __| |_ 
#  | | (_) | (_| | (_| | |_) | (_| | | (_| | | | | (_|  __/ |_ | |_|  _|
#  |_|\___/ \__,_|\__,_|_.__/ \__,_|_|\__,_|_| |_|\___\___|_(_) \__|_|  
                                                                      

#=====#
# ALB #
#=====#
resource "aws_lb" "alb" {

  name               = "${local.name_prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_servers_sg.id]
  
  # Here we have to get creative to loop through our subnets without using the for_each meta-argument
  subnets            = [for k, v in var.availability_zones : aws_subnet.aws_subnet.aws_subnet.("${local.name_prefix}-${each.key}-app-sn").id

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.lb_logs_bucket.id
    prefix  = "${local.name_prefix}-alb"
    enabled = true
  }

  tags = {
    Environment = var.env
  }
}

#==============#
# ALB Listener #
#==============#
resource "aws_alb_listener" "web_server_listener" {

  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_servers.arn
  }
}
#==================#
# ALB Target Group #
#==================#
resource "aws_lb_target_group" "web_servers" {
  
  name     = "${local.name_prefix}-tg"
  target_type = "alb"
  port        = 80
  protocol    = "TCP"
  vpc_id      = aws_vpc.main_vpc.id
}

#=============================#
# ALB Target Group Attachment #
#=============================#
resource "aws_lb_target_group_attachment" "target_group_attachment" {
for_each = var.availability_zones

  target_group_arn = aws_lb_target_group.web_servers.arn
  target_id        = aws_instance.web_server[each.key].id
  port             = 80
}
