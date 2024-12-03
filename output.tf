output "role_name" {
  value = aws_iam_role.this[0].name
}

output "role_arn" {
  value = aws_iam_role.this[0].arn
}

output "instance_profile" {
  value = var.instance_profile_create ? aws_iam_instance_profile.this[0].name : ""
}