terraform {
  //required_version = "0.11.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = var.region
  //access_key = var.AWScreds["accesskeyID"]
  //secret_key = var.AWScreds["secretkey"]
}
