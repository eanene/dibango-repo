output "user_arn" {
  description = "ARN of the IAM user"
  value = {
    for user_name, user_config in aws_iam_user.IAM-ro-users: user_name => user_config.arn
  }
}

output "password" {
    value = aws_iam_user_login_profile.new_user_login
  
}


output "login_url" {
    value = "https://aws.amazon.com/console"
  
}