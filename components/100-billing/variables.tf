variable "region" {
  type        = string
  description = "The region where the resources will be created."
  default     = "af-johannesburg-1"
}

variable "token_doppler_iac_cloud_main" {
  type        = string
  description = "The Doppler token for the secrets manager cloud main repo."
}

variable "project" {
  type        = string
  description = "(optional) describe your variable"
  default     = "oci-cloud-helios"
}

variable "component" {
  type        = string
  description = "(optional) describe your variable"
  default     = "billing"
}

variable "bucket_key_iac" {
  type        = string
  description = "The prefix for the bucket key."
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket."
}

variable "bucket_region" {
  type        = string
  description = "The region of the bucket."
}
