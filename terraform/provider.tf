provider "aws" {
  region = var.region
}

terraform {
  required_version = ">= 0.15"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
###############################create these 2 resources first
/* resource "aws_s3_bucket" "mybucket" {
    bucket = "cmcloudlab893-info"
    versioning {
        enabled = true
    }
    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }
}

##create dynamodb
resource "aws_dynamodb_table" "statelock" {
    name = "state-lock"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
} */

// Local Backend Example
// terraform {
//  backend "local" {
//    path = "./$HOME/$USER/terraform.tfstate"
//  }
// }

#once above resources are created, replace line 5 code with the below to save tfstate on s3 backend

# terraform {
#     required_version = ">= 0.14.7"
#     backend "s3" {
#         bucket = "s3statebackend-3212"
#         dynamodb_table = "state-lock"
#         key ="global/mystatefile/terraform.tfstate"
#         region = "us-east-1"
#         encrypt = true
#     }
#   required_providers {
#     kubectl = {
#       source  = "gavinbunney/kubectl"
#       version = ">= 1.7.0"
#     }

#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 3.0"
#     }
#   }
# }
