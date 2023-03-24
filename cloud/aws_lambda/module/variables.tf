variable "function_name" {
    description = "The name of the function."
    type = string
    nullable = false
}

variable "event_rule" {
    description = "The event rule that triggers the Lambda function. It accepts resource `aws_cloudwatch_event_rule`"
    type = object({
        name = string
        arn = string
    })
    nullable = false
}

################################################################################
# Source Code
################################################################################

variable "handler" {
    description = "The function entrypoint in your code."
    type = string
    default = "main.lambda_handler"
}

variable source_dir {
    description = "The directory containing the source code."
    type = string
    nullable = false
}

variable "runtime" {
    description = "The identifier of the function's runtime."
    type = string
    default = "python3.7"
}

variable "environment_variables" {
    description = "A map that defines environment variables for the Lambda function. You can refer to these environment variables in the function's code."
    type = map(string)
    default = {}
}

################################################################################
# IAM Role
################################################################################

variable "iam_role_arn" {
  description = "Existing IAM role ARN for the lambda. Required if `create_iam_role` is set to `false`"
  type        = string
  default     = null
}

variable "create_iam_role" {
    description = "Whether to create an IAM role for the Lambda function."
    type = bool
    default = false
}

variable "iam_role_name" {
  description = "Name to use on IAM role created"
  type        = string
  default     = null
}

variable "iam_role_additional_policies" {
  description = "Additional policies to be added to the IAM role"
  type        = list(string)
  default     = []
}