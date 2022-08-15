<!-- BEGIN_TF_DOCS -->
# terraform-aws-transfer-server-ad

GitHub: [StratusGrid/terraform-aws-transfer-server-ad](https://github.com/StratusGrid/terraform-aws-transfer-server-ad)

This Repo is meant to act as a template which can be used
when creating new modules.

<span style="color:red">**Notes:</span>
- Don't forget to change the module source repo tag in `tags.tf`!
- Please remove all of the unnecessary initial documentation from the `.terraform-docs.yml` file as they exist purely to make the module and not for continual publishing.
- Update the examples and include the Terraform registry information and proper version constraint. A version constraint would generally look like this `~> 1.0`

## Example

```hcl
module "template_terraform_module_starter" {
  source  = "StratusGrid/template-terraform-module-starter/aws"
  version = "1.0.0"
  # source   = "github.com/StratusGrid/terraform-aws-template-terraform-module-starter"
  name       = "${var.name}-template-terraform-module-starter${local.name_suffix}"
  input_tags = merge(local.common_tags, {})
}
```

## StratusGrid Standards we assume

- All resource names shall use `_` and not `-`s
- The old naming standard for common files such as inputs, outputs, providers, etc was to prefix them with a `-`, this is no longer true as it's not POSIX compliant. Our pre-commit hooks will fail with this old standard.
- StratusGrid generally follows the TerraForm standards outlined [here](https://www.terraform-best-practices.com/naming)

## Repo Knowledge

This repo has several base requirements
- This repo is based upon the AWS `~> 4.9.0` provider
- The following packages are installed via brew: `tflint`, `terrascan`, `terraform-docs`, `gitleaks`, `tfsec`, `pre-commit`, `go`
- Install `bash` through Brew for Bash 5.0, otherwise it will fail with the error that looks like `declare: -g: invalid option`
- If you need more tflint plugins, please edit the `.tflint.hcl` file with the instructions from [here](https://github.com/terraform-linters/tflint)
- It's highly recommend that you follow the Git Pre-Commit Instructions below, these will run in GitHub though they should be ran locally to reduce issues
- By default Terraform docs will always run so our auto generated docs are always up to date
- This repo has been tested with [awsume](https://stratusgrid.atlassian.net/wiki/spaces/TK/pages/1564966913/Awsume)
- The Terraform module standard is to place everything in the `main.tf` file, and this works well for small modules. Though StratusGrid suggests breaking it out into multiple files if the module is larger or touches many resources such as data blocks.
- StratusGrid requires the tag logic be used and every resource within the module be tagged with `local.tags`

### TFSec

See the pre-commit tfsec documentation [here](https://github.com/antonbabenko/pre-commit-terraform#terraform_tfsec), this includes on how to bypass warnings

## Apply this template via Terraform

### Before this is applied, you need to configure the git hook on your local machine
```bash
#Verify you have bash5
brew install bash

# Test your pre-commit hooks - This will force them to run on all files
pre-commit run --all-files

# Add your pre-commit hooks forever
pre-commit install
```

### Template Documentation

A sample template Git Repo with how we should setup client infrastructure, in this case it's shared infrastructure.
More details are available [here](https://stratusgrid.atlassian.net/wiki/spaces/MS/pages/2065694728/MSP+Client+Setup+-+Procedure) in confluence.

## Documentation

This repo is self documenting via Terraform Docs, please see the note at the bottom.

### `LICENSE`
This is the standard Apache 2.0 License as defined [here](https://stratusgrid.atlassian.net/wiki/spaces/TK/pages/2121728017/StratusGrid+Terraform+Module+Requirements).

### `outputs.tf`
The StratusGrid standard for Terraform Outputs.

### `README.md`
It's this file! I'm always updated via TF Docs!

### `tags.tf`
The StratusGrid standard for provider/module level tagging. This file contains logic to always merge the repo URL.

### `variables.tf`
All variables related to this repo for all facets.
One day this should be broken up into each file, maybe maybe not.

### `versions.tf`
This file contains the required providers and their versions. Providers need to be specified otherwise provider overrides can not be done.

## Documentation of Misc Config Files

This section is supposed to outline what the misc configuration files do and what is there purpose

### `.config/.terraform-docs.yml`
This file auto generates your `README.md` file.

### `.config/terrascan.yaml`
This file has all of the configuration options required for Terrascan, this is where you would skip rules to.

### `.github/sync-repo-settings.yaml`
This file is our standard for how GitHub branch protection rules should be setup.

### `.github/workflows/pre-commit.yml`
This file contains the instructions for Github workflows, in specific this file run pre-commit and will allow the PR to pass or fail. This is a safety check and extras for if pre-commit isn't run locally.

### `.vscode/settings.json`
This file is a vscode workspace settings file.

### `examples/*`
The files in here are used by `.config/terraform-docs.yml` for generating the `README.md`. All files must end in `.tfnot` so Terraform validate doesn't trip on them since they're purely example files.

### `.gitignore`
This is your gitignore, and contains a slew of default standards.

### `.pre-commit-config.yaml`
This file is the GIT pre-commit file and contains all of it's configuration options

### `.prettierignore`
This file is the ignore file for the prettier pre-commit actions. Specific files like our auto generated README have to be ignored.

### `.python-version`
Specifies the Python version that the `actions/setup-python` in GitHub Actions should use.

### `.tflint.hcl`
This file contains the plugin data for TFLint to run.

---

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.9 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.aws_transfer_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.aws_transfer_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_transfer_access.sftp_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_access) | resource |
| [aws_transfer_server.sftp_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/transfer_server) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_dns_hostname"></a> [custom\_dns\_hostname](#input\_custom\_dns\_hostname) | Boolean to enable Custom Hostname integration with R53 | `bool` | n/a | yes |
| <a name="input_directory_id"></a> [directory\_id](#input\_directory\_id) | AWS Managed AD Directory ID or AWS Directory Connector ID | `string` | n/a | yes |
| <a name="input_input_tags"></a> [input\_tags](#input\_input\_tags) | Map of tags to apply to resources | `map(string)` | <pre>{<br>  "Developer": "StratusGrid",<br>  "Provisioner": "Terraform"<br>}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | name to prepend to all resource names within module | `string` | n/a | yes |
| <a name="input_premade_s3_bucket"></a> [premade\_s3\_bucket](#input\_premade\_s3\_bucket) | Use the pre-made S3 bucket and policies included in the module, or use a custom S3 bucket. | `bool` | `true` | no |
| <a name="input_r53_hosted_zone_id"></a> [r53\_hosted\_zone\_id](#input\_r53\_hosted\_zone\_id) | R53 Hosted Zone ID for Custom Hostname | `string` | n/a | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | Bucket Name if premade\_s3\_bucket is set to FALSE | `string` | `null` | no |
| <a name="input_transfer_access_sids"></a> [transfer\_access\_sids](#input\_transfer\_access\_sids) | External SIDs allowed access to the Transfer Server | `list(string)` | n/a | yes |

## Outputs

No outputs.

---

Note, manual changes to the README will be overwritten when the documentation is updated. To update the documentation, run `terraform-docs -c .config/.terraform-docs.yml`
<!-- END_TF_DOCS -->