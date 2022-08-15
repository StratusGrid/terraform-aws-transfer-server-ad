output "sftp_server_cname" {
  description = "Add this DNS hostname as a CNAME to your var.custom_dns_hostname input"
  value       = aws_transfer_server.sftp_server.endpoint
}
