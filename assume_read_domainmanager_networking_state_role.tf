# Attach to the provisioners users group the IAM policy (created in
# cisagov/cool-domain-manager-networking) that allows assumption of the role
# in the Terraform account that allows read-only access to the
# cool-domain-manager-networking Terraform state.
resource "aws_iam_group_policy_attachment" "assume_read_domainmanager_networking_state_role" {
  provider = aws.users

  group = aws_iam_group.provisioner_users.name
  # There is only one Users account, so both domainmanager_networking
  # remote states (production and staging) point to the same
  # "assume_read_terraform_state_role_policy".  Therefore, it doesn't
  # matter which remote state we use here.
  policy_arn = data.terraform_remote_state.domainmanager_networking_staging.outputs.read_terraform_state.assume_policy.arn
}
