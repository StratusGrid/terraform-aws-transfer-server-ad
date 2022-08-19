<!-- BEGIN_TF_DOCS -->
# terraform-aws-transfer-server-ad

GitHub: [StratusGrid/terraform-aws-transfer-server-ad](https://github.com/StratusGrid/terraform-aws-transfer-server-ad)

This is a Terraform module to interact with the AWS Transfer Family SFTP service and integrate it Microsoft AD through an AWS Managed AD, or a directory connector.


<span style="color:red">**Notes:</span>
- If you're using AWS Managed AD, and you have RADIUS MFA turned on this will *NOT* work. This is an undocumented "feature" of AWS. You will need to create a directory connector to Managed AD in question. Doing this will allow you to bypass the MFA gate.

## Example - No Custom DNS

```hcl
module "test" {
    source = "StratusGrid/transfer-server-ad"
    version = #Relevant Version here

    directory_id = "AWSDirectoryID"
    transfer_access_sids = ["S-1-5-21-1180699209-877415012-3182924384-1004","S-1-5-21-1180699209-877417590-3182924384-1004"]
    name = "test11"
    r53_hosted_zone_id = "Z00000000000A0BCDEFGH"
    custom_dns_hostname = "sftp.example.com"
}
```

## Example - Custom DNS

```hcl
module "test" {
    source = "StratusGrid/transfer-server-ad"
    version = #Relevant Version here

    directory_id = "AWSDirectoryID"
    transfer_access_sids = ["S-1-5-21-1180699209-877415012-3182924384-1004","S-1-5-21-1180699209-877417590-3182924384-1004"]
    name = "test11"
    r53_hosted_zone_id = "Z00000000000A0BCDEFGH"
    custom_dns_hostname = "sftp.example.com"
}
```

## Documentation

---

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.9 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.1.1 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.aws_transfer_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.aws_transfer_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_transfer_access.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_access) | resource |
| [aws_transfer_server.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_server) | resource |
| [null_resource.aws_transfer_server_custom_hostname](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_dns_hostname"></a> [custom\_dns\_hostname](#input\_custom\_dns\_hostname) | FQDN for custom DNS for SFTP Server | `string` | `""` | no |
| <a name="input_directory_id"></a> [directory\_id](#input\_directory\_id) | AWS Managed AD Directory ID or AWS Directory Connector ID | `string` | n/a | yes |
| <a name="input_enable_custom_dns"></a> [enable\_custom\_dns](#input\_enable\_custom\_dns) | Boolean to enable custom DNS for Transfer Family | `bool` | n/a | yes |
| <a name="input_input_tags"></a> [input\_tags](#input\_input\_tags) | Map of tags to apply to resources | `map(string)` | <pre>{<br>  "Developer": "StratusGrid",<br>  "Provisioner": "Terraform"<br>}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | name to prepend to all resource names within module | `string` | n/a | yes |
| <a name="input_premade_s3_bucket"></a> [premade\_s3\_bucket](#input\_premade\_s3\_bucket) | Use the pre-made S3 bucket and policies included in the module, or use a custom S3 bucket. | `bool` | `true` | no |
| <a name="input_r53_hosted_zone_id"></a> [r53\_hosted\_zone\_id](#input\_r53\_hosted\_zone\_id) | R53 Hosted Zone ID for Custom Hostname | `string` | `""` | no |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | Bucket Name if premade\_s3\_bucket is set to FALSE | `string` | `null` | no |
| <a name="input_transfer_access_sids"></a> [transfer\_access\_sids](#input\_transfer\_access\_sids) | External SIDs allowed access to the Transfer Server | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sftp_server_cname"></a> [sftp\_server\_cname](#output\_sftp\_server\_cname) | Add this DNS hostname as a CNAME to your var.custom\_dns\_hostname input |

---

Note, manual changes to the README will be overwritten when the documentation is updated. To update the documentation, run `terraform-docs -c .config/.terraform-docs.yml`
<!-- END_TF_DOCS -->