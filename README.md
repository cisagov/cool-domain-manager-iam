# cool-domain-manager-iam #

[![GitHub Build Status](https://github.com/cisagov/cool-domain-manager-iam/workflows/build/badge.svg)](https://github.com/cisagov/cool-domain-manager-iam/actions)

This project is used to manage IAM permissions for
[Domain Manager](https://github.com/cisagov/domain-manager-cicd) users.

## Pre-requisites ##

- The user accounts for all users must have been created previously.  We
recommend using the
[`cisagov/cool-users-non-admin`](https://github.com/cisagov/cool-users-non-admin)
repository to create users.
- The User Services account and roles must have been created using [`cisagov/cool-accounts-userservices`](https://github.com/cisagov/cool-accounts-userservices).

## Usage ##

1. Create a Terraform workspace (if you haven't already done so) by running
   `terraform workspace new <workspace_name>`
1. Create a `<workspace_name>.tfvars` file with all of the required
  variables (see [Inputs](#Inputs) below for details):

  ```hcl
  users = {
    "firstname1.lastname1"    = { "roles" = ["provisioner"] },
    "firstname2.lastname2"    = { "roles" = ["provisioner"] }
  }
  ```

1. Run the command `terraform init`.
1. Run the command `terraform apply
  -var-file=<workspace_name>.tfvars`.

## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 0.12.0 |
| aws | ~> 3.0 |

## Providers ##

| Name | Version |
|------|---------|
| aws | ~> 3.0 |
| aws.users | ~> 3.0 |
| terraform | n/a |

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| assume_access_dm_terraform_backend_policy_description | The description to associate with the IAM policy that allows assumption of the role that allows access to Domain Manager-related Terraform backend resources. | `string` | `The IAM policy that allows assumption of the role that allows access to Domain Manager-related Terraform backend resources.` | no |
| assume_access_dm_terraform_backend_policy_name | The name to assign the IAM policy that allows assumption of the role that allows access to Domain Manager-related Terraform backend resources. | `string` | `AssumeAccessDomainManagerTerraformBackend` | no |
| assume_provisiondomainmanager_policy_description | The description to associate with the IAM policy that allows assumption of the role that allows sufficient permissions to provision all AWS resources for Domain Manager in the User Services accounts. | `string` | `The IAM policy that allows assumption of the role that allows sufficient permissions to provision all AWS resources for Domain Manager in the User Services accounts.` | no |
| assume_provisiondomainmanager_policy_name | The name to assign the IAM policy that allows assumption of the role that allows sufficient permissions to provision all AWS resources for Domain Manager in the User Services accounts. | `string` | `UserServices-AssumeProvisionDomainManager` | no |
| assume_sharedservices_provisionprivatednsrecords_policy_name | The name to assign the IAM policy that allows assumption of the role that allows access to provision DNS records in private zones in the Shared Services account. | `string` | `SharedServices-AssumeProvisionPrivateDNSRecords` | no |
| aws_region | The AWS region to deploy into (e.g. us-east-1) | `string` | `us-east-1` | no |
| provisioner_users_group_name | The name of the group to be created for provisioner users. | `string` | `domain_manager_provisioners` | no |
| tags | Tags to apply to all AWS resources created | `map(string)` | `{}` | no |
| users | A map containing the usernames of each Domain Manager user and a list of roles assigned to that user.  The only currently-defined role is "provisioner".  Example: { "firstname1.lastname1" = { "roles" = [ "provisioner" ] } } | `map(map(list(string)))` | n/a | yes |

## Outputs ##

No output.

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
