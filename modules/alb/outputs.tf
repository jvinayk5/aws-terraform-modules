output "dns_name" {
  description = "DNS name of the load balancer."
  value       = aws_lb.this.dns_name
}

output "security_group_id" {
  description = "Security group attached to the load balancer."
  value       = aws_security_group.this.id
}

output "target_group_arn" {
  description = "Target group to register services with."
  value       = aws_lb_target_group.this.arn
}
