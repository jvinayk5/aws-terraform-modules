variable "name" {
  description = "Name prefix for the load balancer and related resources."
  type        = string
}

variable "vpc_id" {
  description = "VPC the load balancer runs in."
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for the load balancer (public for internet-facing, private for internal)."
  type        = list(string)
}

variable "internal" {
  description = "Create an internal load balancer."
  type        = bool
  default     = false
}

variable "allowed_ingress_cidrs" {
  description = "CIDR blocks allowed to reach the load balancer."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "certificate_arn" {
  description = "ACM certificate. When set, HTTP redirects to HTTPS."
  type        = string
  default     = null
}

variable "target_port" {
  description = "Port the targets listen on."
  type        = number
  default     = 8080
}

variable "health_check_path" {
  description = "HTTP path used for target health checks."
  type        = string
  default     = "/healthz"
}

variable "tags" {
  description = "Tags applied to every resource."
  type        = map(string)
  default     = {}
}
