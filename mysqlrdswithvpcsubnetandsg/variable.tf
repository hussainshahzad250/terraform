variable "region" {
  type        = string
  description = "Provide region"
}

variable "environment" {
  type    = string
  default = "UAT"
}

variable "clientName" {
  type = string
}

variable "product" {
  type = string
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR range"
}

variable "public_subnet_cidr" {
  type        = string
  default     = ""
  description = "public subnet cidr range"
}

variable "private_subnet_cidr" {
  type        = string
  default     = ""
  description = "private subnet cidr range"
}

