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

variable "dbstorage" {
  type        = string
  default     = ""
  description = "description"
}

variable "publicly_accessible" {
  type        = bool
  default     = false
  description = "description"
}

variable "skip_final_snapshot" {
  type        = bool
  default     = false
  description = "description"
}

variable "username" {
  type        = string
  description = "description"
}

variable "password" {
  type        = string
  description = "description"
}

variable "db_instance_class" {
  type        = string
  description = "description"
}

variable "storage_type" {
  type        = string
  default     = ""
  description = "description"
}
variable "engine" {
  type        = string
  default     = ""
  description = "description"
}
variable "engine_version" {
  type        = string
  default     = ""
  description = "description"
}
variable "identifier" {
  type        = string
  default     = ""
  description = "description"
}






