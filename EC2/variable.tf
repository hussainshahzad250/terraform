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
variable "amiId" {
  type        = string
  description = "description"
}
