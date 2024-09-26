provider "google" {
  credentials = file("abstract-stream-434813-f1-f062f58713cf.json")
  project     = "abstract-stream-434813-f1"
  region      = "us-central1"
}

# Define a Google Compute Engine instance
resource "google_compute_instance" "nginx_server" {
  name         = "nginx-server"
  machine_type = "n2-standard-2"  # Adjust as needed
  zone         = "us-central1-a"  # Match with the provider zone

  # Define the boot disk
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10-buster-v20200910"  # Use a valid image
    }
  }

  # Define the network interface
  network_interface {
    network = "default"
    access_config {
      // Include this block to assign a public IP address
    }
  }

  # Define firewall rules to allow HTTP traffic
  metadata = {
    startup-script = <<-EOF
      #! /bin/bash
      sudo apt update
      sudo apt install -y nginx
      sudo systemctl start nginx
      sudo systemctl enable nginx
      EOF
  }
}

