# Workspace Setup

Infrastructure-as-code examples for provisioning and configuring Databricks workspaces across AWS, Azure, and GCP.

## Contents

### Terraform Examples

Self-contained, scenario-based Terraform configurations based on real customer deployments. See the [terraform-examples README](terraform-examples/README.md) for full details.

| Cloud | Scenario | Description |
|-------|----------|-------------|
| AWS | [aws-byovpc](terraform-examples/aws/aws-byovpc/) | Bring Your Own VPC with Unity Catalog, IAM cross-account roles, and S3 root storage |
| Azure | [azure-vnet-injection](terraform-examples/azure/azure-vnet-injection/) | VNet injection with NAT gateway, new or existing VNet, and optional metastore |
| Azure | [azure-privatelink-classic](terraform-examples/azure/azure-privatelink-classic/) | Private Link (classic) with VNet injection, private endpoints for control plane and DBFS |
| GCP | [gcp-byovpc-standalone](terraform-examples/gcp/gcp-byovpc-standalone/) | Customer-managed VPC with Cloud Router, Cloud NAT, and service account impersonation |

### Temp Tools

| Tool | Description |
|------|-------------|
| [S3 Policy Migration](temp-tools/S3%20Policy%20Migration/) | Utility for migrating S3 bucket policies |

## Getting Started

1. Navigate to the scenario that matches your cloud and deployment requirements
2. Follow the scenario-specific README for prerequisites, authentication, and deployment steps
3. Each scenario's Terraform files are in a `tf/` subdirectory — run `terraform init` from there
