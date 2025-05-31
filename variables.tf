#                   _       _     _            _    __ 
#                  (_)     | |   | |          | |  / _|
#  __   ____ _ _ __ _  __ _| |__ | | ___  ___ | |_| |_ 
#  \ \ / / _` | '__| |/ _` | '_ \| |/ _ \/ __|| __|  _|
#   \ V / (_| | |  | | (_| | |_) | |  __/\__ \| |_| |  
#    \_/ \__,_|_|  |_|\__,_|_.__/|_|\___||___(_)__|_|  
                                                     
#========================#
# Define Variables Here  #
#========================#

variable "vpc_cidr" {
    type = string
}

variable "subnet_cidr" {
    type = map(string)
}

variable "region" {
    type    = string
    default = "us-east-1"
}

variable "az" {
    type = list
}

variable "org_name" {
    type = string

    validation {
        condition     = length(var.org_name) > 4 && length(var.env) < 20
        error_message = "Must be between 2 and 20 characters, example: abc-corp"
    }
}

variable "env" {
    type = string

    validation {
        condition     = length(var.env) > 3 && length(var.env) < 10
        error_message = "Must be between 3 and 10 characters, example: prod"
    }
}

variable "sn_incrementer" {
    type    = number
    default = 0
}

variable "server_pair" {
    type    = bool
    default = true
}

variable "ssh_key_pair" {
    type = string
}
