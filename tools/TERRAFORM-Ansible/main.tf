terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      #version = "2.9.8"
      version = "2.8.0"
    }
  }
}

provider "proxmox" {
  pm_tls_insecure = true
  pm_api_url      = var.proxmox-access.api_proxmox
  pm_password     = var.proxmox-access.pass-proxmox
  pm_user         = var.proxmox-access.user-proxmox
  pm_otp          = ""
}


resource "proxmox_vm_qemu" "clona-vm" {
  count                     = var.vm-config.num-vms  
  target_node               = var.proxmox-access.node-proxmox
  clone                     = var.vm-config.imagem-base
  name                      = "${var.vm-config.imagem-resultante}-${count.index}"  
  os_type                   = "cloud-init"
  ciuser                    = var.vm-config.user
  cipassword                = var.vm-config.psswd-user
  vmid                      = "${var.vm-config.id-vm}${count.index}"
  agent                     = 1  
  boot                      = "c"
  memory                    = var.vm-config.memoria
  cpu                       = "kvm64"
  cores                     = var.vm-config.cpu_core_vm
  sockets                   = var.vm-config.socket_cpu_vm
  define_connection_info    = true
  ipconfig0                 = "ip=dhcp"
  numa                      = true  

  sshkeys = <<EOF
   ${var.vm-config.key-pub-pub}
EOF

  disk {
    type    = "scsi"
    storage = "local-lvm"
    size    = "${var.vm-config.tamanho-disco}"
    backup  = 1
    ssd     = 1
    discard = "on"
  }

  network {
    bridge    = "vmbr0"
    firewall  = false
    link_down = false
    model     = "virtio"
    queues    = 0
    rate      = 0
    tag       = -1
  }

  provisioner "local-exec" {

    command = "ANSIBLE_CONFIG=ansible-config/ansible.cfg ansible-playbook -i '${self.ssh_host},' ansible-config/playbook-config-ubuntu.yml"

  }

}

output "proxmox-vm-output" {
  value = [proxmox_vm_qemu.clona-vm[*].name, proxmox_vm_qemu.clona-vm[*].default_ipv4_address]
}
