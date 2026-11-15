variable "name" {
  description = "Repository name."
  type        = string
}

variable "keep_last_images" {
  description = "Number of most recent images to keep."
  type        = number
  default     = 30
}

variable "kms_key_arn" {
  description = "KMS key for encryption. Leave null to use AES256."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags applied to every resource."
  type        = map(string)
  default     = {}
}
