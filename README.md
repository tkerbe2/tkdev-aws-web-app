# tkdev Terraform Web App Lab

I've created this lab to tinker with some different ways to create resources with Terraform in AWS and improve my own Terraform skills. This lab is a simple example of many of the cool things you can create with some simple looping and other functions.

I recommend using Terraform Enterprise Cloud to deploy this as it is what I've used to deploy this. GitHub Actions is also a great alternative if you can set the AWS_SERCET_KEY and AWS_ACCESS_KEY in the Secrets.

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

## References

| Reference      | Description   | 
| ---------------|---------------|
| [for_each Meta Argument](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)| Official Hashicorp Documentation for the for_each Meta-Argument
| [lookup Function](https://developer.hashicorp.com/terraform/language/functions/lookup) | Official Hashicorp Documentation for the lookup function
| [cidrsubnet Function](https://developer.hashicorp.com/terraform/language/functions/cidrsubnet) | Official Hashicorp Documentation for the cidrsubnet function
| [random_string](https://registry.terraform.io/providers/hashicorp/random/3.0.0/docs/resources/string) | Official Terraform Registry for random provider
