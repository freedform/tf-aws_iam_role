locals {
  managed_policies = length(var.managed_policies) > 0 ? {
    for policy in var.managed_policies : md5(policy) => policy
  } : {}
}

resource "aws_iam_role" "this" {
  count                 = var.create_role ? 1 : 0
  name                  = var.role_name
  description           = var.role_description
  path                  = var.role_path
  permissions_boundary  = var.permissions_boundary
  max_session_duration  = var.max_session_duration
  force_detach_policies = var.force_detach_policies
  assume_role_policy = templatefile("${path.module}/assume_role_policy.json", {
    service_name = var.service_name
  })
}

resource "aws_iam_role_policy" "inline_policy" {
  count  = var.create_role && var.inline_policy != null ? 1 : 0
  name   = "${var.role_name}_inline_policy"
  role   = aws_iam_role.this[0].id
  policy = var.inline_policy
}

resource "aws_iam_role_policy_attachment" "managed_policies" {
  count      = var.create_role ? length(var.managed_policies) : 0
  policy_arn = var.managed_policies[count.index]
  role       = aws_iam_role.this[0].name
}

resource "aws_iam_instance_profile" "this" {
  count = var.create_role && var.instance_profile_create ? 1 : 0
  name  = var.role_name
  role  = aws_iam_role.this[0].name
}