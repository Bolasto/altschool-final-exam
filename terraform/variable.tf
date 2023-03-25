variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list(any)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "security_group_name" {
  description = "Security group name"
  type        = string
  default     = "tito-cluster-sg"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Cluster Name"
  type        = string
  default     = "tito-cluster"
}



# Define the associations variable
variable "associations" {
  type = map(object({
    action = string
  }))

  default = {
    "alb-listener" = {
      action = "ALLOW"
    }
  }
}

variable "env" {
  description = "Environment variable abbreviation"
  type        = string
  default     = "staging"
}

# validation {
#     condition     = contains(["staging", "prod"], var.env)
#     error_message = "Invalid argument \"env\", please choose one of: (\"staging\",\"prod\")."
# }