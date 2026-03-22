######################################################
# Outputs
######################################################
output "workspace_url" {
  description = "URL of the Databricks workspace"
  value       = databricks_mws_workspaces.databricks_workspace.workspace_url
}

output "workspace_id" {
  description = "ID of the Databricks workspace"
  value       = databricks_mws_workspaces.databricks_workspace.workspace_id
}

output "network_id" {
  description = "ID of the Databricks MWS network configuration"
  value       = databricks_mws_networks.databricks_network.network_id
}

output "vpc_id" {
  description = "Name of the Google VPC network"
  value       = google_compute_network.databricks_vpc.id
}

output "subnet_id" {
  description = "ID of the Google Compute subnetwork"
  value       = google_compute_subnetwork.databricks_subnet.id
}
