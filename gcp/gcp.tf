provider "google" {
  credentials = file("regal-dynamo-156812-6d681745de01.json")
  project     = "regal-dynamo-156812"
  region      = "europe-central2"
  zone        = "europe-central2-a"
}

resource "google_compute_instance" "my_server" {
  name         = "my-gcp-server"
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}
