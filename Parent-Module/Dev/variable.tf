variable "rg" {}
variable "stgacc" {}
variable "vnet" {}
variable "subnet" {}
variable "nsg" {}
variable "pubip" {}
variable "vm" {}
variable "admin_username" {
  type = string
}

variable "admin_password" {
  type      = string
  sensitive = true
}