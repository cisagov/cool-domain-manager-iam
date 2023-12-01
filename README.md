# cool-domain-manager-iam #

[![GitHub Build Status](https://github.com/cisagov/cool-domain-manager-iam/workflows/build/badge.svg)](https://github.com/cisagov/cool-domain-manager-iam/actions)

This project is used to manage IAM permissions for
[Domain Manager](https://github.com/cisagov/domain-manager-cicd) users.

## Pre-requisites ##

- [Terraform](https://www.terraform.io/) installed on your system.
- An accessible AWS S3 bucket to store Terraform state
  (specified in [backend.tf](backend.tf)).
- An accessible AWS DynamoDB database to store the Terraform state lock
  (specified in [backend.tf](backend.tf)).
- Access to all of the Terraform remote states specified in
  [remote_states.tf](remote_states.tf).
- User accounts for all users must have been created previously.  We
  recommend using the
  [`cisagov/cool-users-non-admin`](https://github.com/cisagov/cool-users-non-admin)
  repository to create users.
- User Services account and roles must have been created using
  [`cisagov/cool-accounts-userservices`](https://github.com/cisagov/cool-accounts-userservices).
- Terraform in
  [`cisagov/cool-domain-manager-networking`](https://github.com/cisagov/cool-domain-manager-networking)
  must have been applied.

## Usage ##

1. Create a Terraform workspace (if you haven't already done so) by running
   `terraform workspace new <workspace_name>`
1. Create a `<workspace_name>.tfvars` file with all of the required
  variables (see [Inputs](#inputs) below for details):

  ```hcl
  users = {
    "firstname1.lastname1"    = { "roles" = ["provisioner"] },
    "firstname2.lastname2"    = { "roles" = ["provisioner"] }
  }
  ```

1. Run the command `terraform init`.
1. Run the command `terraform apply
  -var-file=<workspace_name>.tfvars`.

<!-- BEGIN_TF_DOCS -->
## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| aws | ~> 4.9 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 4.9 |
| aws.users | ~> 4.9 |
| terraform | n/a |

## Modules ##

No modules.

## Resources ##

| Name | Type |
|------|------|
| [aws_iam_group.provisioner_users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_policy.assume_sharedservices_provisionprivatednsrecords_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy) | resource |
| [aws_iam_group_policy_attachment.assume_access_dm_terraform_backend_role_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.assume_domainmanager_provisionaccount_role_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.assume_read_domainmanager_networking_state_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.assume_read_sharedservices_networking_state_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.assume_access_dm_terraform_backend_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.assume_domainmanager_provisionaccount_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_user_group_membership.provisioner](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_access_dm_terraform_backend_role_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_domainmanager_provisionaccount_role_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_sharedservices_provisionprivatednsrecords_role_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_user.users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_user) | data source |
| [terraform_remote_state.domainmanager_networking_staging](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.domainmanager_production](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.domainmanager_staging](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.sharedservices_networking_production](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.sharedservices_networking_staging](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.terraform](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.users](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| assume\_access\_dm\_terraform\_backend\_policy\_description | The description to associate with the IAM policy that allows assumption of the role that allows access to Domain Manager-related Terraform backend resources. | `string` | `"The IAM policy that allows assumption of the role that allows access to Domain Manager-related Terraform backend resources."` | no |
| assume\_access\_dm\_terraform\_backend\_policy\_name | The name to assign the IAM policy that allows assumption of the role that allows access to Domain Manager-related Terraform backend resources. | `string` | `"AssumeAccessDomainManagerTerraformBackend"` | no |
| assume\_domainmanager\_provisionaccount\_policy\_description | The description to associate with the IAM policy that allows assumption of the role that allows sufficient permissions to provision all AWS resources for Domain Manager in the Domain Manager accounts. | `string` | `"The IAM policy that allows assumption of the role that allows sufficient permissions to provision all AWS resources for Domain Manager in the Domain Manager accounts."` | no |
| assume\_domainmanager\_provisionaccount\_policy\_name | The name to assign the IAM policy that allows assumption of the role that allows sufficient permissions to provision all AWS resources for Domain Manager in the Domain Manager accounts. | `string` | `"DomainManager-AssumeProvisionAccount"` | no |
| assume\_sharedservices\_provisionprivatednsrecords\_policy\_name | The name to assign the IAM policy that allows assumption of the role that allows access to provision DNS records in private zones in the Shared Services account. | `string` | `"SharedServices-AssumeProvisionPrivateDNSRecords"` | no |
| aws\_region | The AWS region to deploy into (e.g. us-east-1) | `string` | `"us-east-1"` | no |
| provisioner\_users\_group\_name | The name of the group to be created for provisioner users. | `string` | `"domain_manager_provisioners"` | no |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |
| users | A map containing the usernames of each Domain Manager user and a list of roles assigned to that user.  The only currently-defined role is "provisioner".  Example: { "firstname1.lastname1" = { "roles" = [ "provisioner" ] } } | `map(map(list(string)))` | n/a | yes |

## Outputs ##

No outputs.
<!-- END_TF_DOCS -->

## Notes ##

Running `pre-commit` requires running `terraform init` in every directory that
contains Terraform code. In this repository, this is just the main directory.

## Contributing ##

We welcome contributions!  Please see [`CONTRIBUTING.md`](CONTRIBUTING.md) for
details.

## License ##

This project is in the worldwide [public domain](LICENSE).

This project is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/).

All contributions to this project will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.
