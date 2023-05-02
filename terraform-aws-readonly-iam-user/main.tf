resource "aws_iam_user" "IAM-ro-users" {
  for_each = toset(var.IAM-ro-users)
  name = replace(each.key, "@", "@")
  path = "/users/"
  tags = {
    Environment = "Dev"
    Department  = "RO-Access"
  }
  force_destroy = true
}

resource "aws_iam_group_policy_attachment" "policy_attachment" {
  group       = aws_iam_group.RO_Group1.name
  policy_arn  = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_group" "RO_Group1" {
  name = "RO-Group1"
}

resource "aws_iam_group_membership" "RO_Group1" {
  for_each = aws_iam_user.IAM-ro-users
  users    = [each.value.name]
  name     = "RO_Group1"
  group    = aws_iam_group.RO_Group1.name
}

resource "aws_iam_group_policy_attachment" "pre_mfa-RO_policy" {
  group = aws_iam_group.RO_Group1.name
  policy_arn = aws_iam_policy.pre_mfa-RO_policy.arn
}

resource "aws_iam_user_login_profile" "new_user_login" {
  for_each                 = aws_iam_user.IAM-ro-users
  user                     = each.value.name
  password_reset_required = true
}

resource "aws_iam_account_password_policy"  "strict" {
    minimum_password_length         = 10
    require_lowercase_characters    = true
    require_numbers                 = true
    require_uppercase_characters    = true
    require_symbols                 = true
    allow_users_to_change_password  = true
}
