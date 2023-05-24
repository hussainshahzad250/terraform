variable "region" {
  type        = string
  description = "Provide region"
}
variable "environment" {
  type        = string
  default     = "UAT"
}
variable "clientName" {
  type        = string
}

variable "product" {
  type        = string
}

variable "create_vpc" {
  description = "Controls if VPC should be created"
  type        = bool
  default     = true
}
variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
}

variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC"
  type        = bool
  default     = true
}
variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_ipv6" {
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block."
  type        = bool
  default     = false
}
