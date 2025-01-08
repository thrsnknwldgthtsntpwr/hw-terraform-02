resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_subnet" "develop-db" {
  name           = "develop-db"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.2.0/24"]
}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_compute-image-family
}

resource "yandex_compute_instance" "platform-web" {
  name        = "${local.name1}-${local.name2}-web"
  platform_id = var.vm_web_platform-id
  resources {
    cores         = var.vm_web_cores
    memory        = var.vm_web_ram
    core_fraction = var.vm_web_core-fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}


resource "yandex_compute_instance" "platform-db" {
  name        = "${local.name1}-${local.name2}-db"
  zone        = "ru-central1-b"
  platform_id = var.vm_db_platform-id
  resources {
    cores         = var.vm_db_cores
    memory        = var.vm_db_ram
    core_fraction = var.vm_db_core-fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop-db.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}