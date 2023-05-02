resource "aws_iam_policy" "pre_mfa-RO_policy" {
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