# IAM policy document that allows assumption of the
# ProvisionPrivateDNSRecords role in the Shared Services account
data "aws_iam_policy_document" "assume_sharedservices_provisionprivatednsrecords_role_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [
      data.terraform_remote_state.sharedservices_networking_production.outputs.provision_private_dns_records_role.arn,
      data.terraform_remote_state.sharedservices_networking_staging.outputs.provision_private_dns_records_role.arn,
    ]
  }
}

# Create an inline policy for the provisioners users group
# NOTE: This policy is created inline because it is identical to a policy
# used elsewhere and we must avoid duplicate policy names.  At this time, we
# don't have a suitable repository to create the policy on its own, so we
# decided to simply add it inline.
resource "aws_iam_group_policy" "assume_sharedservices_provisionprivatednsrecords_role" {
  provider = aws.users

  name   = var.assume_sharedservices_provisionprivatednsrecords_policy_name
  group  = aws_iam_group.provisioner_users.name
  policy = data.aws_iam_policy_document.assume_sharedservices_provisionprivatednsrecords_role_doc.json
}
