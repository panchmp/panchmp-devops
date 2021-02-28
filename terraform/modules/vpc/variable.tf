variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

variable "subnet_cidr" {
  description = "subnet_cidr"
  type = string
  default = "10.10.0.0/16"
}