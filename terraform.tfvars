#   _                       __                      _    __                     
#  | |                     / _|                    | |  / _|                    
#  | |_ ___ _ __ _ __ __ _| |_ ___  _ __ _ __ ___  | |_| |___   ____ _ _ __ ___ 
#  | __/ _ \ '__| '__/ _` |  _/ _ \| '__| '_ ` _ \ | __|  _\ \ / / _` | '__/ __|
#  | ||  __/ |  | | | (_| | || (_) | |  | | | | | || |_| |  \ V / (_| | |  \__ \
#   \__\___|_|  |_|  \__,_|_| \___/|_|  |_| |_| |_(_)__|_|   \_/ \__,_|_|  |___/
                                                                              

#========================#
# Declare Variables Here #
#========================#

# Enter the AWS region to deploy to
# Defaults to us-east-1
region = "us-east-1"

# Between 2 and 20 characters
org_name = "tkdev"

# Environment between 3 and 10 characters
# Could be prod, dev, non-prod
env = "prod"

# If you want a pair of servers or not
# Naming convention is pri (primary) or sec (secondary)
# Default value is true

# No default value, fill out
ssh_key_pair = "tkdev-ssh-key"

# VM instance type
instance_type = "t3.micro"


#====================#
# Network Variables  #
#====================#

# /20 supports up to 4,096 IPs
# 192.168.96.1 - 192.168.111.254
# 15 usable /24 networks
vpc_cidr = "192.168.96.0/23"

# AZ list  used for naming and looping mechanism
availability_zones = {
    0 = "us-east-1a"
    1 = "us-east-1b"
}

# How many subnets to create
# This should match the availability_zones


# What size of network you want
# 5 is a /28
borrowed_bits = 5