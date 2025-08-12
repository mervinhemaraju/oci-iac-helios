variable "region" {
  type        = string
  description = "The region where the resources will be created."
  default     = "af-johannesburg-1"
}

variable "token_doppler_global" {
  type        = string
  description = "The Doppler token for the secrets manager cloud main repo."
}
