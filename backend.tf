terraform {
  required_version = ">= 1.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
  backend "gcs" {
    bucket = "project-2dadfd71-b08e-4164-b79-tfstate"
    prefix = "terraform/state"
  }
}