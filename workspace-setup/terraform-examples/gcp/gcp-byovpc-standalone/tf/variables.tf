variable "google_service_account_email" {
  description = "Email of the Google Service Account used by providers"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.iam\\.gserviceaccount\\.com$", var.google_service_account_email))
    error_message = "Must be a valid GCP service account email (ending in .iam.gserviceaccount.com)."
  }
}

variable "google_project_name" {
  description = "GCP project ID where resources will be created"
  type        = string
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{4,28}[a-z0-9]$", var.google_project_name))
    error_message = "Must be a valid GCP project ID: 6-30 characters, lowercase letters, digits, and hyphens."
  }
}

variable "google_region" {
  description = "GCP region for resources (e.g., us-central1)"
  type        = string
  validation {
    condition = contains([
      "asia-east1", "asia-east2", "asia-northeast1", "asia-northeast2", "asia-northeast3",
      "asia-south1", "asia-south2", "asia-southeast1", "asia-southeast2",
      "australia-southeast1", "australia-southeast2",
      "europe-central2", "europe-north1", "europe-southwest1",
      "europe-west1", "europe-west2", "europe-west3", "europe-west4", "europe-west6", "europe-west8", "europe-west9", "europe-west10", "europe-west12",
      "me-central1", "me-central2", "me-west1",
      "northamerica-northeast1", "northamerica-northeast2",
      "southamerica-east1", "southamerica-west1",
      "us-central1", "us-east1", "us-east4", "us-east5", "us-south1", "us-west1", "us-west2", "us-west3", "us-west4"
    ], var.google_region)
    error_message = "Must be a valid GCP region supported by Databricks."
  }
}

variable "databricks_account_id" {
  description = "Databricks Account ID"
  type        = string
  sensitive   = true
}

variable "databricks_workspace_name" {
  description = "Name for the Databricks workspace"
  type        = string
}

variable "databricks_admin_user" {
  description = "Admin user email to add to the workspace (must exist at Account level)"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for the Databricks subnet"
  type        = string
  validation {
    condition     = can(cidrhost(var.subnet_cidr, 0))
    error_message = "Must be a valid CIDR block (e.g., 10.10.0.0/20)."
  }
}
