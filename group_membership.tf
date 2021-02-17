# Put provisioner users in the appropriate group
resource "aws_iam_user_group_membership" "provisioner" {
  provider = aws.users

  for_each = toset([for username, attributes in var.users : username if contains(attributes["roles"], "provisioner")])

  user = data.aws_iam_user.users[each.key].user_name

  groups = [
    aws_iam_group.provisioner_users.name
  ]
}
