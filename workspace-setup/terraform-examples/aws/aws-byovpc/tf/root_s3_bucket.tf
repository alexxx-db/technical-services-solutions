resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_s3_bucket" "root_storage_bucket" {
  bucket        = "${var.resource_prefix}-workspace-root-storage-${random_string.bucket_suffix.result}"
  force_destroy = true
  tags = merge(
    var.tags,
    {
      Name    = "${var.resource_prefix}-workspace-root-storage"
      Project = var.resource_prefix
    }
  )
}

resource "aws_s3_bucket_server_side_encryption_configuration" "root_bucket_encryption" {
  bucket = aws_s3_bucket.root_storage_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "root_bucket" {
  bucket                  = aws_s3_bucket.root_storage_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "root_bucket" {
  bucket = aws_s3_bucket.root_storage_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

data "databricks_aws_bucket_policy" "this" {
  databricks_e2_account_id = var.databricks_account_id
  bucket                   = aws_s3_bucket.root_storage_bucket.bucket
}

resource "aws_s3_bucket_policy" "root_bucket_policy" {
  bucket     = aws_s3_bucket.root_storage_bucket.id
  policy     = data.databricks_aws_bucket_policy.this.json
  depends_on = [aws_s3_bucket_public_access_block.root_bucket]

  lifecycle {
    # Databricks may update the bucket policy via the API after creation.
    # Ignore policy changes to avoid reverting Databricks-managed policies.
    ignore_changes = [policy]
  }
}

