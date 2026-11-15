variable "name" {
  description = "Identifier for the database instance."
  type        = string
}

variable "vpc_id" {
  description = "VPC the database runs in."
  type        = string
}

variable "subnet_ids" {
  description = "Private subnets for the database subnet group."
  type        = list(string)
}

variable "allowed_security_group_ids" {
  description = "Security groups allowed to connect to the database."
  type        = list(string)
  default     = []
}

variable "engine" {
  description = "Database engine."
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "Engine version."
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "Instance size."
  type        = string
  default     = "db.t4g.micro"
}

variable "allocated_storage" {
  description = "Initial storage in GiB."
  type        = number
  default     = 20
}

variable "port" {
  description = "Database port."
  type        = number
  default     = 3306
}

variable "multi_az" {
  description = "Run a standby in another AZ."
  type        = bool
  default     = false
}

variable "backup_retention_days" {
  description = "Days to keep automated backups."
  type        = number
  default     = 7
}

variable "deletion_protection" {
  description = "Block accidental deletion."
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Skip the final snapshot on destroy. Use true only in dev."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to every resource."
  type        = map(string)
  default     = {}
}
