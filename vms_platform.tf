## Virtual Machines vars
variable "vm_web_compute-image-family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS Family to install"
}

variable "vm_web_platform-id" {
  type        = string
  default     = "standard-v2"
  description = "Platform id for vm on yc"
}

variable "vm_web_cores" {
  type        = number
  default     = 2
}

variable "vm_web_ram" {
  type        = number
  default     = 1
  description = "ram volume in GB"
}

variable "vm_web_core-fraction" {
  type        = number
  default     = 5
  description = "cpu usage max"
}



variable "vm_db_compute-image-family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS Family to install"
}

variable "vm_db_platform-id" {
  type        = string
  default     = "standard-v2"
  description = "Platform id for vm on yc"
}

variable "vm_db_cores" {
  type        = number
  default     = 2
}

variable "vm_db_ram" {
  type        = number
  default     = 2
  description = "ram volume in GB"
}

variable "vm_db_core-fraction" {
  type        = number
  default     = 20
  description = "cpu usage max"
}