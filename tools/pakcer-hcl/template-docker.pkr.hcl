
source "proxmox-clone" "flisol2022" {
  proxmox_url              = "${var.proxmox_url}"
  username                 = "${var.proxmox_username}"
  password                 = "${var.proxmox_password}"
  node                     = "${var.promox_node}"
  insecure_skip_tls_verify = true

  clone_vm                 = "ub20.04-cloudimg-custom-amd64"    
  template_name            = "ub20.04-flisol-temp-packer"
  template_description     = "Template via Packer para o Flisol Belém 2022"  
  vm_id                    = 400  
  boot_wait                = "3600s"
  full_clone               = true   
  bios                     = "seabios"  
  
  os                       = "l26"
  boot                     = "order=scsi0"
  memory                   = 2048
  cpu_type                 = "host"
  cores                    = 1
  sockets                  = 1   
  
  ssh_timeout              = "60m"
  ssh_username             = "root"
  task_timeout             = "30m"
  
  scsi_controller          = "virtio-scsi-single"  

  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }
}

build {
  description = "A template for building a base"

  sources = ["source.proxmox-clone.flisol2022"]

  provisioner "ansible" {
    playbook_file = "./ansible-config/playbook-config-ubuntu.yml"
  }

}
