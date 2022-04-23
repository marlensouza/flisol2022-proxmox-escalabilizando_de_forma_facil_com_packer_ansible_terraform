variable "promox_node" {
  type    = string
  default = "centauro"
}

variable "proxmox_password" {
  type    = string
  default = "AbCd4321"
}

variable "proxmox_url" {
  type    = string
  default = "https://192.168.1.12:8006/api2/json"
}

variable "proxmox_username" {
  type    = string
  default = "marlen@pve"
}
