
#                        _     _           _    __ 
#   _ __  _ __ _____   _(_) __| | ___ _ __| |_ / _|
#  | '_ \| '__/ _ \ \ / / |/ _` |/ _ \ '__| __| |_ 
#  | |_) | | | (_) \ V /| | (_| |  __/ |_ | |_|  _|
#  | .__/|_|  \___/ \_/ |_|\__,_|\___|_(_) \__|_|  
#  |_|                                             


#======================#
#  AWS Provider Block  #
#======================#
provider "aws" {
  region = var.region
}

terraform {
  required_providers {
    random = {
      source = "hashicorp/random" 
      version = "3.6.3"
    }
  }
}
