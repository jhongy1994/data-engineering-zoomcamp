locals {
  data_lake_bucket = "dgc_data_lake"
}

variable "project" {
  description = "GCP Project ID"
}

variable "region" {
  description = "Region for GCP resources."
  default = "asia-northeast3"
  type = string
}

variable "storage_class" {
  description = "Storage class type for bucket."
  default = "STANDARD"
}

variable "BQ_DATASET" {
  description = "BigQuery Dataset that raw data will be written to"
  type = string
  default = "trips_data_all"
}