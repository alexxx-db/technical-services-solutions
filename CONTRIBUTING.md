# Contributing to Technical Services Solutions

Thank you for contributing to the Technical Services Solutions repository. This guide covers the standards and process for submitting new projects or improvements.

## Getting Started

1. Fork and clone the repository
2. Create a feature branch from `main` (direct commits to `main` are blocked by pre-commit hooks)
3. Make your changes following the guidelines below
4. Submit a pull request

## Repository Structure

Place your project in the appropriate category directory:

```
technical-services-solutions/
├── core-platform/           # Platform configs, admin, networking, cost management
├── data-engineering/        # ETL/ELT, DLT, streaming, batch processing, orchestration
├── data-governance/         # Unity Catalog, access controls, lineage, compliance
├── data-warehousing/        # SQL warehouses, data modeling, migrations, BI integration
├── genai-ml/                # Model training/serving, GenAI, RAG, MLOps
├── launch-accelerator/      # Quickstart templates, onboarding, reference architectures
└── workspace-setup/         # Workspace provisioning, Terraform IaC examples
```

## Naming Conventions

- Use **lowercase with hyphens** for all directory and file names
- Terraform scenario folders: `{cloud}-{network-type}-{security-features}` (e.g., `aws-byovpc`, `azure-vnet-injection-privatelink`)
- Be descriptive — avoid generic names like `scenario1` or `example`

## Required Files

Every project must include:

| File | Purpose |
|------|---------|
| `README.md` | Overview, prerequisites, deployment steps, validation, troubleshooting, teardown |
| `variables.tf` | Input variable declarations with validation rules |
| `outputs.tf` | Output values with descriptions |
| `versions.tf` | Terraform and provider version constraints |
| `terraform.tfvars.example` | Example values (never commit real secrets) |

For Terraform projects, place all `.tf` files in a `tf/` subdirectory within the scenario folder.

## Code Standards

### Terraform
- Include **validation rules** on all input variables (region lists, CIDR format, naming patterns)
- Add **descriptions** to all outputs
- Use the standardized provider aliases: `account` for account-level, `workspace` for workspace-level Databricks providers
- Pin provider versions consistently with existing scenarios (Databricks `~> 1.84`, Terraform `~> 1.3`)
- Include inline comments explaining key decisions
- Run `terraform fmt` before committing

### Documentation
- Write clear, customer-friendly documentation
- Include sections: Overview, Prerequisites, Authentication, Variables, Deployment, Validation, Troubleshooting, Teardown
- Assume the reader is new to Databricks and Terraform
- Include actual command examples

## Security Requirements

All contributions **must** comply with these requirements:

- **No customer data, PII, or proprietary information**
- **No credentials, tokens, or passwords** — use environment variables or `terraform.tfvars` (which is gitignored)
- **Only synthetic data** (use Faker, dbldatagen, or similar)
- **Acknowledge third-party licenses** in `LICENSE-THIRD-PARTY.md` if introducing new dependencies
- **Pass all CI checks** — TruffleHog secret scanning and tfsec Terraform security scanning run automatically on PRs

## Pre-commit Hooks

Install pre-commit hooks before making changes:

```bash
pre-commit install
```

Hooks enforce: `terraform fmt`, `terraform validate`, tflint rules (naming conventions, documented variables/outputs, typed variables, required versions), license detection, private key detection, and trailing whitespace fixes.

## Pull Request Process

1. Fill out the PR template completely, including the security compliance checklist
2. Ensure all CI checks pass (terraform-lint, security-scan)
3. Request review from the appropriate Regional SME (AMER, APJ, or EMEA)
4. Address all review feedback before merge

## Regional SME Support

- **AMER** — Americas
- **APJ** — Asia Pacific & Japan
- **EMEA** — Europe, Middle East & Africa

Contact your regional SME for guidance on contribution scope and review.

## License

By contributing, you agree that your contributions will be licensed under the [Databricks License](https://databricks.com/db-license-source).
