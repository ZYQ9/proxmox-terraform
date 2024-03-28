# Environment Variables 
variable "PM_API_URL" {}
variable "PM_USER" {}
variable "PM_PASS" {}

# Input Variables 
variable "pm_target_node" {
  type = string
}
variable "vm_name" {
  type = string
}

variable "vmid" {
  description = "ID for the VM, when left at 0 Proxmox will assign the next available ID."
  type = number
  default = 0
}

variable "memory" {
  description = "Memory size in MB"
  type = number
  default = 2048
}

variable "cores" {
  description = "Number of CPU cores per CPU Socket to allocate to VM"
  type = number
  default = 2
}

variable "sockets" {
  description = "Number of CPU Sockets to allocate to VM"
  type = number
  default = 2
}