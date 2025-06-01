#   _                 _      _    __ 
#  | |               | |    | |  / _|
#  | | ___   ___ __ _| |___ | |_| |_ 
#  | |/ _ \ / __/ _` | / __|| __|  _|
#  | | (_) | (_| (_| | \__ \| |_| |  
#  |_|\___/ \___\__,_|_|___(_)__|_|  
                                   
                  
locals {
    
#===============#
# Naming Prefix #
#===============#
    name_prefix = "${var.org_name}-${local.region_code}-${var.env}"
    # use1 = var.env == "us-east-1" ? "use1" : ""
    # use2 = var.env == "us-east-2" ? "use2" : ""
    # usw1 = var.env == "us-west-1" ? "usw1" : ""
    # usw2 = var.env == "us-west-2" ? "usw2" : ""
    # region-code = coalesce(local.use1, local.use2, local.usw1, local.usw2)

#===================#
# Region Map Lookup #
#===================#
    region_map = {
        "us-east-1" = "use1"
        "us-east-2" = "use2"
        "us-west-1" = "usw1"
        "us-west-2" = "usw2"
    }
    region_code = lookup(local.region_map, var.region)



}
