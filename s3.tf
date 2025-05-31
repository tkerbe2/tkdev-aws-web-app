#       ____  _    __ 
#      |___ \| |  / _|
#   ___  __) | |_| |_ 
#  / __||__ <| __|  _|
#  \__ \___) | |_| |  
#  |___/____(_)__|_|  


#===============#
# Random String #
#===============#

# An example of using random string to generate some random numbers to fill our bucket name
# AWS S3 bucket names have to be globally unique so this is an easy way to accomplish this
resource "random_string" "random_bucket_name" {
  length = 10
  special = false
  lower = false
  upper = false
  numeric = true

}
#===========#
# S3 Bucket #
#===========#

# This creates an S3 bucket with our random string
resource "aws_s3_bucket" "lb_logs_bucket" {
  bucket = "${local.name_prefix}-${random_string.random_bucket_name.result}-bucket"

  tags = {
    Name        = "${local.name_prefix}-${random_string.random_bucket_name.result}-bucket"
    Environment = var.env
  }
}
