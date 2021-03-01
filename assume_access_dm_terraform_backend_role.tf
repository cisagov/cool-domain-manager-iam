# IAM policy document that allows assumption of the
# AccessDomainManagerTerraformBackend role in the Terraform account
data "aws_iam_policy_document" "assume_access_dm_terraform_backend_role_doc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    resources = [
      data.terraform_remote_state.terraform.outputs.access_domainmanager_terraform_backend_role.arn,
    ]
  }
}

resource "aws_iam_policy" "assume_access_dm_terraform_backend_role" {
  provider = aws.users

  description = var.assume_access_dm_terraform_backend_policy_description
  name        = var.assume_access_dm_terraform_backend_policy_name
  policy      = data.aws_iam_policy_document.assume_access_dm_terraform_backend_role_doc.json
}

# Attach the policy to the provisioners users group
resource "aws_iam_group_policy_attachment" "assume_access_dm_terraform_backend_role_attachment" {
  provider = aws.users

  group      = aws_iam_group.provisioner_users.name
  policy_arn = aws_iam_policy.assume_access_dm_terraform_backend_role.arn
}
