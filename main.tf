resource "google_compute_network" "web" {
  name                    = "web"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "web" {
  name          = "web"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-west1"
  network       = google_compute_network.web.id
}

data "google_compute_image" "ubuntu" {
  most_recent = true
  project     = "ubuntu-os-cloud" 
  family      = "ubuntu-2204-lts"
}

resource "google_compute_instance" "web" {
  name         = "brutal-venom"
  machine_type = "e2-micro"

  
  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
    }
  }
  network_interface {
   subnetwork = "web"
   access_config {
      # Leave empty for dynamic public IP
    }
  }  

  allow_stopping_for_update = true
}
