# ------------------------------------------------------------------------------
# REQUIRED PARAMETERS
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "users" {
  type        = map(map(list(string)))
  description = "A map containing the usernames of each Domain Manager user and a list of roles assigned to that user.  The only currently-defined role is \"provisioner\".  Example: { \"firstname1.lastname1\" = { \"roles\" = [ \"provisioner\" ] } }"
}

# ------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "assume_access_dm_terraform_backend_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows assumption of the role that allows access to Domain Manager-related Terraform backend resources."
  default     = "The IAM policy that allows assumption of the role that allows access to Domain Manager-related Terraform backend resources."
}

variable "assume_access_dm_terraform_backend_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows assumption of the role that allows access to Domain Manager-related Terraform backend resources."
  default     = "AssumeAccessDomainManagerTerraformBackend"
}

variable "assume_provisiondomainmanager_policy_description" {
  type        = string
  description = "The description to associate with the IAM policy that allows assumption of the role that allows sufficient permissions to provision all AWS resources for Domain Manager in the User Services accounts."
  default     = "The IAM policy that allows assumption of the role that allows sufficient permissions to provision all AWS resources for Domain Manager in the User Services accounts."
}

variable "assume_provisiondomainmanager_policy_name" {
  type        = string
  description = "The name to assign the IAM policy that allows assumption of the role that allows sufficient permissions to provision all AWS resources for Domain Manager in the User Services accounts."
  default     = "UserServices-AssumeProvisionDomainManager"
}

variable "aws_region" {
  type        = string
  description = "The AWS region to deploy into (e.g. us-east-1)"
  default     = "us-east-1"
}

variable "provisioner_users_group_name" {
  type        = string
  description = "The name of the group to be created for provisioner users."
  default     = "domain_manager_provisioners"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created"
  default     = {}
}
