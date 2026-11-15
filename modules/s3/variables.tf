variable "bucket_name" {
  description = "Globally unique bucket name."
  type        = string
}

variable "versioning_enabled" {
  description = "Keep object versions."
  type        = bool
  default     = true
}

variable "kms_key_arn" {
  description = "KMS key for encryption. Leave null to use SSE-S3 (AES256)."
  type        = string
  default     = null
}

variable "noncurrent_version_expiration_days" {
  description = "Days after which old object versions are deleted."
  type        = number
  default     = 90
}

variable "force_destroy" {
  description = "Allow Terraform to delete a non-empty bucket. Keep false outside of dev."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to every resource."
  type        = map(string)
  default     = {}
}
