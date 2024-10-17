terraform {
#   backend "azurerm" {
#     bucket         = "my-terraform-state-bucket"
#     key            = "infrastructure/terraform.tfstate"
#     region         = "us-west-2"
#     dynamodb_table = "terraform-locks"
#   }

    backend "azurerm" {
    resource_group_name   = "terraformstatesRG"
    storage_account_name  = "terraformstate737"
    container_name        = "tfstateblob"
    key                   = "aws/s3website/terraform.tfstate"
  }
}