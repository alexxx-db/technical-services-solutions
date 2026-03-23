resource "databricks_metastore" "metastore" {
  count         = var.metastore_id == "" ? 1 : 0
  provider      = databricks.account
  name          = var.metastore_name
  region        = var.region
  force_destroy = var.force_destroy_metastore
}

resource "databricks_metastore_assignment" "this" {
  metastore_id = var.metastore_id == "" ? databricks_metastore.metastore[0].id : var.metastore_id
  provider     = databricks.account
  workspace_id = databricks_mws_workspaces.this.workspace_id
  # Wait for workspace API to stabilize before assigning metastore.
  depends_on = [time_sleep.wait_2_minutes]
}


