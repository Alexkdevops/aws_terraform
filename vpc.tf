module "vpc" {
    source = "git@github.com:terraform-aws-modules/terraform-aws-vpc.git"

    name = var.VPC_NAME
    cidr = var.VpcCIDR
    azs = [var.Zone1, var.Zone2]
    private_subnets = [var.PrivSub1CIDR, var.PrivSub2CIDR]
    public_subnets = [var.PubSub1CIDR, var.PubSub2CIDR]

    enable_nat_gateway  = false
    single_nat_gateway  = true
    enable_dns_support  = true
    enable_dns_hostnames = true

    tags = {
        Terraform  = "true"
        Enironment = "Prod"  
    }

    vpc_tags = {
        Name = var.VPC_NAME
    }
}