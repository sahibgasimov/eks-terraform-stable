provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 0.14.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

// terraform {
//   backend "s3" {
//     bucket = "sgasimov-bucket"
//     key    = "path/to/my/key"
//     region = "us-east-1"
//     dynamodb_table = "prod"
//   }
// }


