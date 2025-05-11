# Cloud Movies – Infrastructure Setup

This project provisions the infrastructure for the Cloud Movies application on Microsoft Azure using Terraform.

## 🧱 Folder Structure

- `infra/dev/` – Terraform configuration for the development environment.
- `infra/prod/` – Terraform configuration for the production environment.
- `modules/` – Reusable Terraform modules (network, storage, compute, etc.)

## 🚀 Getting Started

### 1. 🔐 Authentication

To avoid issues with accessing the Key Vault (e.g., missing `client_id` or `object_id`), it's **highly recommended** to authenticate using a **Service Principal**.

Create a Service Principal and assign proper roles (Contributor or above):

```bash
az ad sp create-for-rbac --name "tf-sp" --role Contributor --scopes /subscriptions/<your-subscription-id> --sdk-auth
```

Then, configure GitHub Secrets or export the following environment variables locally:

```bash
export ARM_CLIENT_ID="<client_id>"
export ARM_CLIENT_SECRET="<client_secret>"
export ARM_SUBSCRIPTION_ID="<subscription_id>"
export ARM_TENANT_ID="<tenant_id>"
```

Alternatively, use GitHub Actions with a self-hosted runner and these secrets.

### 2. 📦 Remote State Initialization

Terraform remote state should be set up first. Go to `infra/dev/remote-state/` (or `infra/prod/remote-state/`) and run:

```bash
terraform init
terraform plan
terraform apply
```

This will create the storage account and container for storing the Terraform state remotely.

### 3. 🌐 Infrastructure Provisioning

After the remote state is set up, go to `infra/dev/` or `infra/prod/` and run:

```bash
terraform init
terraform plan
terraform apply
```

Modules will provision:
- Resource Group
- VNet + Subnets
- Storage Account
- Application Insights
- Key Vault (with secrets)
- App Service Plan
- Function App / Web App

The infrastructure also uses Application Insights and Key Vault secrets injected as environment variables.

### 4. 🔑 Secrets

Secrets (e.g., CosmosDB connection string, App Insights keys) are stored in Azure Key Vault and automatically created via Terraform. The application reads these at runtime.

## 💡 Application Configuration

To run the application successfully:
- It’s recommended to use **OIDC login**
- Make sure required environment variables are provided via Key Vault
- CI/CD can be configured in `.github/workflows/`

## 🛠️ Useful Commands

```bash
# Plan
terraform plan -var="env=dev"

# Apply
terraform apply -var="env=dev"

# Destroy
terraform destroy -var="env=dev"
```

---

