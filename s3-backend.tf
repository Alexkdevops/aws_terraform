terraform {
  backend "s3" {
    bucket  = "aws-terraform-project"
    key     = "terraform/terraform.tfstate"
    region  = "us-east-1"
  }
}