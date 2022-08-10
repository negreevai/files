provider "google" {
  credentials = file("regal-dynamo-156812-6d681745de01.json")
  project     = "regal-dynamo-156812"
  region      = "europe-central2"
  zone        = "europe-central2-a"
}

#resource "google_project_service" "api" {
#  for_each = toset([
#    "cloudresoursemanager.googleapis.com",
#    "compute.googleapis.com"
#  ])
#  disable_on_destroy = false
#
#}
resource "google_compute_firewall" "web" {
  name          = "web-access"
  network       = "default"
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

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
  metadata_startup_script = <<EOF
#!/bin/bash
sudo su
apt update -y
apt install apache2 -y
echo "<h2>Webserber on GCP Build By Terraform!<h2>" > /var/www/html/index.html
systemctl restart apache2
EOF

  depends_on = [google_project_service.api, google_compute_firewall.web]
}
