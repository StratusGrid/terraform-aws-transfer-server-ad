variable "name" {
  description = "name to prepend to all resource names within module"
  type        = string
}

variable "input_tags" {
  description = "Map of tags to apply to resources"
  type        = map(string)
  default = {
    Developer   = "StratusGrid"
    Provisioner = "Terraform"
  }
}

variable "directory_id" {
  description = "AWS Managed AD Directory ID or AWS Directory Connector ID"
  type        = string
}

variable "premade_s3_bucket" {
  description = "Use the pre-made S3 bucket and policies included in the module, or use a custom S3 bucket."
  type        = bool
  default     = true
}

variable "s3_bucket_name" {
  description = "Bucket Name if premade_s3_bucket is set to FALSE"
  type        = string
  default     = null
}

variable "transfer_access_sids" {
  description = "External SIDs allowed access to the Transfer Server"
  type        = list(string)
}

variable "enable_custom_dns" {
  description = "Boolean to enable custom DNS for Transfer Family"
  type        = bool
}

variable "custom_dns_hostname" {
  description = "FQDN for custom DNS for SFTP Server"
  type        = string
  default     = ""
}

variable "r53_hosted_zone_id" {
  description = "R53 Hosted Zone ID for Custom Hostname"
  type        = string
  default     = ""
}
