variable "region" {
  description = "AWS Region Id"
  default     = "us-east-1"
}

variable "infra_id" {
  description = "unique identifier"
  default     = "108-account"
}

variable "env" {
  description = "Environment: dev/stag/prod"
  default     = "dev"
}

variable "cluster" {
  description = "server details"
  default     = "dev"
}

