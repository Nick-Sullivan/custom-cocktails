terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }
  # Key is dynamic, provided by the makefile
  backend "s3" {
    bucket = "nicks-terraform-states"
    region = "ap-southeast-2"
  }
}

provider "aws" {
  region = "ap-southeast-2"
  default_tags {
    tags = local.tags
  }
}

data "aws_caller_identity" "identity" {}

locals {
  prefix           = "CustomCocktails-${title(var.environment)}"
  prefix_lower     = "custom-cocktails-${lower(var.environment)}"
  prefix_parameter = "/CustomCocktails/${title(var.environment)}"
  aws_account_id   = data.aws_caller_identity.identity.account_id
  root_dir         = "${path.root}/../.."
  lambda_dir       = "${local.root_dir}/lambda"

  tags = {
    Project     = "Custom Cocktails"
    Environment = var.environment
  }
}
