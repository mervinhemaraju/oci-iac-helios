
variable "bucket_name" {
  description = "The name of the S3 bucket to store the Terraform state file"
  type        = string
}

variable "region" {
  description = "The AWS region to create the S3 bucket in"
  type        = string
}

variable "bucket_key_prefix" {
  description = "The prefix to use for the S3 bucket key"
  type        = string
}

variable "before_init_script" {
  description = "The script to run before running terraform init"
  type        = string
}
