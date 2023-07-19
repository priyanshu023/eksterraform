terraform {
  required_providers {
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
      version = "~> 4.67"
    }
  }
}

# auth to aws cloud
provider "aws" {
	region     = "ap-south-1"
    profile    = "default"

}