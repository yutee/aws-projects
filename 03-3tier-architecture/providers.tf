terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraformstatesRG"
    storage_account_name = "terraformstate737"
    container_name       = "tfstateblob"
    key                  = "aws/3tier/terraform.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
}