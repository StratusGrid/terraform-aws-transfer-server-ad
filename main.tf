resource "null_resource" "aws_transfer_server_custom_hostname" {
  provisioner "local-exec" {
    command = <<EOF
aws transfer tag-resource \
  --arn '${aws_transfer_server.this.arn}' \
  --tags \
    Key=aws:transfer:route53HostedZoneId,Value=/hostedzone/${var.r53_hosted_zone_id} \
    Key=aws:transfer:customHostname,Value=${var.custom_dns_hostname}
EOF
  }

  triggers = {
    hosted_zone = var.r53_hosted_zone_id
    hostname    = var.custom_dns_hostname
  }

  depends_on = [
    aws_transfer_server.this
  ]
}

resource "aws_transfer_server" "this" {
  identity_provider_type = "AWS_DIRECTORY_SERVICE"
  directory_id           = var.directory_id
  domain                 = "S3"
  endpoint_type          = "PUBLIC"
  security_policy_name   = "TransferSecurityPolicy-2022-03"
  protocols              = ["SFTP"]
  logging_role           = aws_iam_role.aws_transfer_role.arn

  tags = local.tags

  /* tags = merge(local.tags, {
    "aws:transfer:route53HostedZoneId" = "/hostedzone/${var.r53_hosted_zone_id}"
    "aws:transfer:customHostname"      = var.custom_dns_hostname
  }) */
}

resource "aws_transfer_access" "this" {
  for_each = toset(var.transfer_access_sids)

  role           = aws_iam_role.aws_transfer_role.arn
  server_id      = aws_transfer_server.this.id
  home_directory = var.premade_s3_bucket == true ? "/${module.sftp_storage_bucket[0].s3_bucket_id}" : "/${var.s3_bucket_name}"
  external_id    = each.value
}
