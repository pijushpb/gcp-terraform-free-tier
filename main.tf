provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_compute_instance" "free_vm" {
  name         = "free-tier-vm"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 30
      type  = "pd-standard"
    }
  }

  network_interface {
    network = "default"
    access_config {} # ephemeral public IP
  }
}
module "bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~> 12.4"

  name       = "pijush-bucket"
  project_id = "project-2dadfd71-b08e-4164-b79"
  location   = "us-east1"
  iam_members = [{
    role   = "roles/storage.objectViewer"
    member = "terraform-sa@project-2dadfd71-b08e-4164-b79.iam.gserviceaccount.com"
  }]
}