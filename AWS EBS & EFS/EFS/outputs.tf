output "efs_id" {
  description = "EFS File System ID"
  value       = aws_efs_file_system.efs.id
}

output "efs_dns_name" {
  description = "EFS DNS name used for mounting"
  value       = aws_efs_file_system.efs.dns_name
}

output "efs_security_group" {
  description = "Security Group ID for EFS"
  value       = aws_security_group.efs_sg.id
}
