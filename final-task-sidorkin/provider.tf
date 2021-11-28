terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "my-academy"
  region  = var.region
}

data "aws_route53_zone" "public" {
  zone_id      = "Z0613573PILAQDZA3856"
  private_zone = false
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

output "aws_caller_identity" {
  value = data.aws_caller_identity.current
}
