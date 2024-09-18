terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.11" # Update based on latest stable version
    }
  }

  required_version = ">= 1.0.0"
}
