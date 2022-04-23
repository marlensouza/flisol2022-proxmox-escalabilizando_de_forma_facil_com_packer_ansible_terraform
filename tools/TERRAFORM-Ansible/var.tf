variable "proxmox-access" {

  type = map(any)
  description = "credenciais do proxmox"

  default = {
    "api_proxmox"  = "https://192.168.1.12:8006/api2/json"
    "user-proxmox" = "marlen@pve"
    "pass-proxmox" = "AbCd4321"
    "node-proxmox" = "centauro"
  }

  sensitive = true
}

variable "vm-config" {

  type = map(any)
  description = "Configuracoes que serão carregada na vm"

  default = {
    "user"              = "marlen"    
    "psswd-user"        = "@BcD4321"    
    "key-pub-pub"       = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDV6QkyYaQD2pMp5fcha33D7xvmwK2XC7BVyWpG+8q2efr5/c/AgnHmdHyd8qMaqlJpa+doPlt5l5YES3nk41NGDKF3lP9ZbbU/WfJJLP5hc7TLBFXfmFaIQ1kRagW8AABrk2vE/0eC9U5HrDFPa/Qs4VL0COECGTwA22dCrEhGtRDponzczcnJWMezIHqyki6y/0SD9pKslZwD41FfBltL/DjxvvUX4vJDK2uWqGu8svuKAdEVNfExnueuoIRYseWcvZSM9bj/BS1ZWZUinAA4zAbiMBuZtJ3H+uQt51Ej77Xv7iUvl9JD/X3cvJ9AhfO2jDO5ymZWaYiVjCpzyN5p key-lab"
    "imagem-base"       = "ub20.04-flisol-temp-packer"
    "imagem-resultante" = "flisol-prod-app"
    "num-vms"           = 1
    "id-vm"             = 20
    "cpu_core_vm"       = 1
    "socket_cpu_vm"     = 1
    "memoria"           = 1024
    "tamanho-disco"     = "8G"
  }

  sensitive = false
}
