variable "handler" {
    description = "The function entrypoint in your code."
    type = string
    default = "main.lambda_handler"
}

variable "function_name" {
    description = "The name of the function."
    type = string
    nullable = false
}

variable source_dir {
    description = "The directory containing the source code."
    type = string
    nullable = false
}

variable "role_arn" {
    description = "The ARN of the IAM role that Lambda assumes when it executes your function to access any other Amazon Web Services (AWS) resources."
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

variable "environment_variables" {
    description = "A map that defines environment variables for the Lambda function. You can refer to these environment variables in the function's code."
    type = map(string)
    default = {}
}

variable "runtime" {
    description = "The identifier of the function's runtime."
    type = string
    default = "python3.7"
}