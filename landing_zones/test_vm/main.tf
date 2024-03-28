terraform {
    required_providers {
        proxmox = {
            source = "telmate/proxmox"
            version = ">= 1.0.0"
        }
    }
}

provider "proxmox" {
    pm_api_url = var.PM_API_URL
    pm_user = var.PM_USER
    pm_password = var.PM_PASS
}


resource "proxmox_vm_qemu" "test_vm" {
    name = var.vm_name
    agent = 0 
    vmid = var.vmid
    cores = var.cores
    sockets = var.sockets
    memory = var.memory
    target_node = var.pm_target_node
    iso = "local:iso/ubuntu-20.04.6-desktop-amd64.iso"

    network {
        model = "virtio" # Default, have seen no reason to change this
    }
    disk {
        type = "scsi"
        storage = "local-lvm"
        size = "32G"
    }
}
