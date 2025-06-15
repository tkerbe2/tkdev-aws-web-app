
![tkdev_secondary](https://github.com/user-attachments/assets/45692378-8f3e-4df0-adb4-74b4d047a0d8)

# Web App Lab

I created this lab as an example for my Hennepin Tech students (or any student interested). The first part of this lab is to create a functioning highly available web application in the AWS Console. The second component of this lab is then deploying these same resources with code. The focus and intent of this lab is to both familiarize with AWS Console (VPC, EC2, IAM) and also recognize the advantages of using IaC.  

### Manual Creation - Web App Lab

I've created this lab to tinker with unique ways to create resources with Terraform, in AWS. I recommend using Terraform Enterprise Cloud to deploy this as it's one of the easier ways to deploy code, manage state files, and store secrets. 

![aws-web-app-lab](https://github.com/user-attachments/assets/f7cf8534-6de9-4748-bc52-3e3efc02daa6)
[Download URL](https://tkdev-content.s3.us-east-1.amazonaws.com/Cloud/tkdev-webapp-w-lb-lab.pdf)

## How to Use:

In the terraform.tfvars file you will want to configure the following variables:

| Variable Name | Value and Constraints |
| ---------------|------------------------------|
| region | Should be a valid AWS region |
| org_name | Can be a fake company or just your name for example | 
| env | This is short for environment think: prod, dev, stage, test, etc.. | 
| ssh_key_pair | Required for EC2 instances to launch, you need to create this yourself first |
| instance_type | I try to keep everything free-tier so t3.micro is default | 
| vpc_cidr | This can be any RFC1918, I recommend at least a /23 CIDR to start with |
| availability_zones | Important! This map is what the looping mechanism is used for. Use valid availability zones and keep the key values as they are (0, 1, 2, etc..) |
| borrowed_bits | This is what size of subnets you want, by default I've set it to 5 to create /28 CIDRs | 

Below is another example of the terraform.tfvars file.

```
#========================#
# Declare Variables Here #
#========================#

# Enter the AWS region to deploy to
# Defaults to us-west-1
region = "us-west-1"

# Between 2 and 20 characters
org_name = "tkdev"

# Environment between 3 and 10 characters
# Could be prod, dev, non-prod
env = "sandbox"

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

# /23 supports up to 512 usable IPs
# 192.168.10.1 - 192.168.11.254
vpc_cidr = "192.168.10.0/23"

# AZ list used for naming and looping mechanism
# us-west-1 doesn't have a b
availability_zones = {
    0 = "us-west-1a"
    1 = "us-west-1c"
}

# How many subnets to create
# This should match the availability_zones


# What size of network you want
# 5 is a /28
borrowed_bits = 5

```


## Resources Created:
This demo creates the following resources in the following order:

1. VPC
2. Subnets based on what is defined in terraform.tfvars
3. IGW attached to the VPC
4. Default route table that points 0.0.0.0/0 to the IGW
5. Security Group that allows 80 and 22 TCP inbound from anywhere (lock this down for further security)
6. EIPs based on how many zones you've defined (default is 2)
7. EC2 Instance(s) with Amazon Linux based on how many zones you've defined (default is 2)
8. S3 bucket with some randomly generated characters (optionally can use this for logging on the ALB) 


<br>

## References:

| Reference      | Description   | 
| ---------------|---------------|
| [for_each Meta Argument](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)| Official Hashicorp Documentation for the for_each Meta-Argument
| [lookup Function](https://developer.hashicorp.com/terraform/language/functions/lookup) | Official Hashicorp Documentation for the lookup function
| [cidrsubnet Function](https://developer.hashicorp.com/terraform/language/functions/cidrsubnet) | Official Hashicorp Documentation for the cidrsubnet function
| [random_string](https://registry.terraform.io/providers/hashicorp/random/3.0.0/docs/resources/string) | Official Terraform Registry for random provider

<br>

## Disclaimer
---
#### Content Usage and Liability

As the author and creator of the content, I authorize the usage, distribution, and modification of my content for individuals (non-commercial entities), non-profit learning institutions (colleges, universities, vocational schools) and any other non-profit organizations that fall under the tax exempt organization status.

#### IRS Exempt Organization Types

My content is NOT to be used, distributed, or modified, for profit or commercial usage without my explicit permission.

As the author of this content I recognize that some of the labs and information I share require more advanced technical knowledge. I take no responsibility for any damages caused by my content (either physical, monetary, or any other damages) and/or shared information. It is assumed that the individual performing these actions is doing so in accordance with their local laws, organizational policies, and self-understanding of personal risk.
