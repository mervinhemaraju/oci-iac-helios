# Get the secrets from the Infisical Secrets Manager
data "infisical_secrets" "cloud_iac_main" {
  env_slug    = "prod"
  folder_path = "/"
}
