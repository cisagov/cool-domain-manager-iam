# An IAM group for provisioner users
resource "aws_iam_group" "provisioner_users" {
  provider = aws.users

  name = var.provisioner_users_group_name
}
