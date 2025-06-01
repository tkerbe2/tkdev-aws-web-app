#               _               _    _    __ 
#              | |             | |  | |  / _|
#    ___  _   _| |_ _ __  _   _| |_ | |_| |_ 
#   / _ \| | | | __| '_ \| | | | __|| __|  _|
#  | (_) | |_| | |_| |_) | |_| | |_ | |_| |  
#   \___/ \__,_|\__| .__/ \__,_|\__(_)__|_|  
#                  | |                       
#                  |_|                       

#=======================#
# Outputs for resources #
#=======================#

output "vpc_main_out" {
    value = aws_vpc.main_vpc.id
}

output "igw_id_out" {
    value = aws_internet_gateway.main_igw.id
}

output "elb_bucket_out" {
    value = aws_s3_bucket.lb_logs_bucket.id
}

output "alb_out" {
    value = aws_lb.alb.id
}