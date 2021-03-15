# IAM policy document that allows assumption of the ProvisionAccount
# role in the Domain Manager account
data "aws_iam_policy_document" "assume_domainmanager_provisionaccount_role_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [
      data.terraform_remote_state.domainmanager_production.outputs.provisionaccount_role.arn,
      data.terraform_remote_state.domainmanager_staging.outputs.provisionaccount_role.arn,
    ]
  }
}

resource "aws_iam_policy" "assume_domainmanager_provisionaccount_role" {
  provider = aws.users

  description = var.assume_domainmanager_provisionaccount_policy_description
  name        = var.assume_domainmanager_provisionaccount_policy_name
  policy      = data.aws_iam_policy_document.assume_domainmanager_provisionaccount_role_doc.json
}

# Attach the policy to the provisioners users group
resource "aws_iam_group_policy_attachment" "assume_domainmanager_provisionaccount_role_attachment" {
  provider = aws.users

  group      = aws_iam_group.provisioner_users.name
  policy_arn = aws_iam_policy.assume_domainmanager_provisionaccount_role.arn
}
