# Brief pause to allow IAM role propagation before creating Databricks credentials.
resource "time_sleep" "wait_30_seconds" {
  create_duration = "30s"
}

resource "databricks_mws_storage_configurations" "this" {
  provider                   = databricks.account
  account_id                 = var.databricks_account_id
  storage_configuration_name = "${var.prefix}-storage"
  bucket_name                = aws_s3_bucket.root_storage_bucket.bucket
}

resource "databricks_mws_credentials" "this" {
  provider         = databricks.account
  role_arn         = aws_iam_role.cross_account_role.arn
  credentials_name = "${var.prefix}-creds"
  depends_on       = [time_sleep.wait_30_seconds]
}

resource "databricks_mws_workspaces" "this" {
  provider                 = databricks.account
  account_id               = var.databricks_account_id
  aws_region               = var.region
  workspace_name           = var.prefix
  credentials_id           = databricks_mws_credentials.this.credentials_id
  storage_configuration_id = databricks_mws_storage_configurations.this.storage_configuration_id
  network_id               = databricks_mws_networks.this.network_id
  pricing_tier             = var.pricing_tier
}

resource "databricks_mws_networks" "this" {
  provider           = databricks.account
  account_id         = var.databricks_account_id
  network_name       = "${var.prefix}-network"
  security_group_ids = length(var.security_group_ids) > 0 ? var.security_group_ids : [module.vpc[0].default_security_group_id]
  subnet_ids         = length(var.subnet_ids) > 0 ? var.subnet_ids : module.vpc[0].private_subnets
  vpc_id             = var.vpc_id == "" ? module.vpc[0].vpc_id : var.vpc_id
}

# Pause after workspace creation to allow Databricks API to stabilize
# before metastore assignment. Needed due to eventual consistency.
resource "time_sleep" "wait_2_minutes" {
  depends_on      = [databricks_mws_workspaces.this]
  create_duration = "120s"
}
