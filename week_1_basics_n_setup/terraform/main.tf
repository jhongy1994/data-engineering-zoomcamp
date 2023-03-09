terraform {
    required_version = ">= 1.3"
    backend "local" {} # "gcs" (for google) or "s3" (for aws), to preserve tf-state online.
    required_providers {
      google = {
        source = "hashicorp/google"
      }
    }
}

provider "google" {
  project = var.project
  region = var.region
#   credentials = file(var.credentials)  # Use this if you do not want to set env-var GOOGLE_APPLICATION_CREDENTIALS
}

# Data Lake - Storage Bucket
#Ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
resource "google_storage_bucket" "data-lake-bucket" {
  name          = "${local.data_lake_bucket}_${var.project}"
  location      = var.region
  force_destroy = true

  storage_class = var.storage_class
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30 // days
    }
  }
}

# Data Ware House
# Ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table
resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = var.BQ_DATASET
  location                    = var.region
  project                     = var.project
}