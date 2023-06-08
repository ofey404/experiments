variable "vpc_name" {
  type        = string
  nullable    = false
  description = "VPC Name"
}

variable "private_subnet_ids" {
  type        = list(string)
  nullable    = false
  description = "Private Subnet IDs"
}

