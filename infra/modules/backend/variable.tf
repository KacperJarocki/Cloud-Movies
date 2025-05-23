variable "rg_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "envs" {
  description = "Environment (e.g., dev, prod)"
  type        = list(string)
}
