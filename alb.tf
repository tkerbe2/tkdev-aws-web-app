
#   _                 _ _           _                           _    __ 
#  | | ___   __ _  __| | |__   __ _| | __ _ _ __   ___ ___ _ __| |_ / _|
#  | |/ _ \ / _` |/ _` | '_ \ / _` | |/ _` | '_ \ / __/ _ \ '__| __| |_ 
#  | | (_) | (_| | (_| | |_) | (_| | | (_| | | | | (_|  __/ |_ | |_|  _|
#  |_|\___/ \__,_|\__,_|_.__/ \__,_|_|\__,_|_| |_|\___\___|_(_) \__|_|  
                                                                      

#=====#
# ALB #
#=====#
resource "aws_lb" "alb" {
for_each = local.availability_zones

  name               = "${local.name_prefix}_alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_servers_sg.id]
  subnets            = aws_subnet.app_sn[each.key].id

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.lb_logs_bucket.id
    prefix  = "${local.name_prefix}_alb"
    enabled = true
  }

  tags = {
    Environment = var.env
  }
}

#==============#
# ALB Listener #
#==============#
resource "aws_lb_listener" "web_server_listener" {
  load_balancer_arn = aws_lb.example.arn
  protocol = "TCP"
  port = 80
  default_action {
    target_group_arn = aws_lb_target_group.web_servers.arn
  }
}

#==================#
# ALB Target Group #
#==================#
resource "aws_lb_target_group" "web_servers" {
  
  name     = "${local.name_prefix}_tg"
  protocol = "TCP"
  port     = 80
  vpc_id   = aws_vpc.main_vpc.id # Replace with your VPC ID
  
  health_check {
    enabled = true
    path = "/"
    port = "traffic-port"
    protocol = "TCP"
    healthy_threshold_count = 2
    unhealthy_threshold_count = 2
    timeout = 5
    interval = 30
  }
}

#=============================#
# ALB Target Group Attachment #
#=============================#
resource "aws_lb_target_group_attachment" "target_group_attachment" {
for_each = local.availability_zones

  target_group_arn = aws_lb_target_group.web_servers.arn
  target_id        = aws_instance.web_server[each.key].id
  port             = 80
}
