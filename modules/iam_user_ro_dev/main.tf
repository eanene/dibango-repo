# resource "aws_iam_user" "IAM-ro-users" {
#   for_each = toset(var.IAM-ro-users)
#   name = replace(each.key, "@", "@")
#   path = "/users/"
#   tags = {
#     Environment = "Dev"
#     Department  = "RO-Access"
#   }
#   force_destroy = true
# }

resource "aws_iam_user" "IAM-ro-users" {
  for_each = toset(var.IAM-ro-users)
  name = replace(each.key, "@", "@")
  tags = merge(var.tags, {Username = each.value})
  force_destroy = var.force_destroy

}

resource "aws_iam_group_policy_attachment" "policy_attachment" {
  group       = aws_iam_group.RO_Group1.name
  policy_arn  = "arn:aws:iam::aws:policy/${var.dynamic_policy}"
}

resource "aws_iam_group" "RO_Group1" {
  name = var.iam_group_name
}

resource "aws_iam_user_group_membership" "RO_Group1" {
  for_each = toset(var.IAM-ro-users)
  user    = aws_iam_user.IAM-ro-users[each.key].name
  # name     = var.iam_group_name
  groups    = [aws_iam_group.RO_Group1.name]
}

resource "aws_iam_group_policy_attachment" "pre_mfa-RO_policy" {
  group = aws_iam_group.RO_Group1.name
  policy_arn = aws_iam_policy.pre_mfa-RO_policy2.arn
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

resource "aws_iam_policy" "pre_mfa-RO_policy2" {
    name = "activate-mfa-policy-fls"
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Sid        = "DenyAllExceptListedIfNotMFA"
                Effect     = "Deny"
                NotAction  = [
                    "iam:CreateVirtualMFADevice",
                    "iam:EnableMFADevice",
                    "iam:GetUser",
                    "iam:ListMFADevice",
                    "iam:ResyncMFADevice",
                    "iam:CreateLoginProfile",
                    "iam:UpdateLoginProfile",
                    "sts:GetSessionToken",
                    "iam:ChangePassword"
                ]

                Resource = "*"
                Condition = {
                    BoolIfExists = {
                        "aws:MultiFactorAuthPresent" = "false"
                    }
                }
            }
        ]

    })
}
