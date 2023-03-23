terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

#####################################################################

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.iam_for_lambda.name
}


resource "aws_iam_role_policy_attachment" "eks" {
  policy_arn = "arn:aws:iam::662391098426:policy/AmazonEKSAdminPolicy"
  role       = aws_iam_role.iam_for_lambda.name
}

#####################################################################

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function_payload.zip"
  function_name = "lambda_function_name"
  role          = aws_iam_role.iam_for_lambda.arn
  handler = "lambda.lambda_handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.7"

  environment {
      variables = {
      "TEST" = "test"
      }
  }
}

#####################################################################

# Create a CloudWatch Event Rule
resource "aws_cloudwatch_event_rule" "timer" {
    name                = "timer"
    description         = "Every 1 minute"
    schedule_expression = "rate(1 minute)"
}

# resource "aws_cloudwatch_event_target" "my_cloudwatch_event_target" {
#   rule      = aws_cloudwatch_event_rule.timer.name
#   target_id = "timer-event-target"
#   arn       = aws_lambda_function.test_lambda.arn
# }

# https://stackoverflow.com/questions/35895315/use-terraform-to-set-up-a-lambda-function-triggered-by-a-scheduled-event-source
# resource "aws_lambda_permission" "allow_cloudwatch_to_call_check_foo" {
#     statement_id = "AllowExecutionFromCloudWatch"
#     action = "lambda:InvokeFunction"
#     function_name = aws_lambda_function.test_lambda.function_name
#     principal = "events.amazonaws.com"
#     source_arn = aws_cloudwatch_event_rule.timer.arn
# }