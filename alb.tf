
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
  subnets            = [for subnet in aws_subnet.app_sn : subnet.id]



  tags = {
    Environment = var.env
  }
}

#==============#
# ALB Listener #
#==============#
resource "aws_alb_listener" "web_server_listener" {

  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_servers_tg.arn
  }
}
#==================#
# ALB Target Group #
#==================#
resource "aws_lb_target_group" "web_servers_tg" {
  
  name     = "${local.name_prefix}-tg"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main_vpc.id

   health_check {
    path = "/"
    port = 80
    healthy_threshold = 6
    unhealthy_threshold = 2
    timeout = 2
    interval = 5
    matcher = "200"  # has to be HTTP 200 or fails
  } 
  
}

#=============================#
# ALB Target Group Attachment #
#=============================#
resource "aws_lb_target_group_attachment" "target_group_attachment" {
count = length(var.availability_zones)

  target_group_arn = aws_lb_target_group.web_servers_tg.arn
  target_id        = aws_instance.web_server[count.index].id
  port             = 80

depends_on = [aws_lb.alb]

}
