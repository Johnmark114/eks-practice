output "password" {
  value = aws_iam_user_login_profile.dev.encrypted_password
}