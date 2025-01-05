variable "create_role" {
  description = "Controls IAM role creation"
  type        = bool
  default     = true
}

variable "instance_profile_create" {
  description = "Controls instance profile creation"
  type        = bool
  default     = true
}

variable "role_name" {
  description = "IAM role name"
  type        = string
}

variable "role_path" {
  description = "Path to the IAM role"
  type        = string
  default     = "/"
}

variable "role_description" {
  description = "IAM role meaningful description"
  type        = string
  default     = ""
}

variable "permissions_boundary" {
  description = "RN of the policy that is used to set the permissions boundary for the role"
  type        = string
  default     = null
}

variable "force_detach_policies" {
  description = "Whether to force detaching any policies the role has before destroying it"
  type        = bool
  default     = true
}

variable "max_session_duration" {
  description = "Maximum session duration (in seconds) of the specified role"
  type        = number
  default     = 3600
}

variable "service_name" {
  description = "Short name of AWS service principal"
  type        = string
}

variable "inline_policy" {
  description = "Inline policy document in json format"
  type        = string
  default     = null
}

variable "managed_policies" {
  description = "List of ARNs of managed IAM polices"
  type        = list(string)
  default     = []
  validation {
    condition     = length(var.managed_policies) <= 10
    error_message = "You can attach up to 10 managed policies"
  }
}

