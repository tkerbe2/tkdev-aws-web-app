
![tkdev_secondary](https://github.com/user-attachments/assets/45692378-8f3e-4df0-adb4-74b4d047a0d8)

# Terraform Web App Lab

I've created this lab to tinker with some different ways to create resources with Terraform in AWS and improve my own Terraform skills. This lab is a simple example of many of the cool things you can create with some simple looping and other functions.

I recommend using Terraform Enterprise Cloud to deploy this as it is what I've used to deploy this. GitHub Actions is also a great alternative if you can set the AWS_SERCET_KEY and AWS_ACCESS_KEY in the Secrets.

## How to Use:

In the terraform.tfvars file you will want to configure the following variables.

| Variable Name | Value and Constraints |
| ---------------|------------------------------|
| region | this should be a valid AWS region |
| org_name | This can be a fake company or just your name for example | 
| env | This is short for environment think: prod, dev, stage, test, etc.. | 
| ssh_key_pair | This is for the EC2 instances to launch, you need to create this yourself first |
| instance_type | By default I try to keep everything free-tier so t3.micro is default | 
| vpc_cidr | This can be any RFC1918, I recommend at least a /23 CIDR to start with |
| availability_zones | This is important as this map is what the looping mechanism is used for. Use valid availability zones and keep the key values as they are |
| borrowed_bits | This is what size of subnets you want, by default I've set it to 5 to create /28 CIDRs | 




## Resources Created:
This demo creates the following resources.

- VPC
- Subnets based on what is defined in terraform.tfvars
- IGW attached to the VPC
- Default route table that points 0.0.0.0/0 to the IGW
- Security Group that allows 80 and 22 TCP inbound from anywhere (lock this down for further security)
- EIPs based on how many zones you've defined (default is 2)
- EC2 Instance(s) with Amazon Linux based on how many zones you've defined (default is 2)
- S3 bucket with some randomly generated characters (optionally can use this for logging on the ALB) 


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
