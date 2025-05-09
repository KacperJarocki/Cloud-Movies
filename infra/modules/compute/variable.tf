variable "project" {
  type = string
}

variable "location" {
  type = string
}
variable "env" {
  type = string
}

variable "rg_name" {
  type = string
}
variable "storage_name" {
  type = string
}
variable "storage_primary_access_key" {
  type = string
}
variable "subnet_id" {

}

variable "connection_string_insight" {
  type = string
}

variable "instrumentation_key_insight" {
  type = string
}
variable "cosmos_db_connection_string" {
  description = "Connection string to the Cosmos DB"
  type        = string
}
