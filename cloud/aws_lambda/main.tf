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

resource "aws_lambda_function" "cluster_down" {
  filename      = "lambda_function_payload.zip"
  source_code_hash = data.archive_file.lambda.output_base64sha256

  function_name = "cluster_down"
  role          = aws_iam_role.iam_for_lambda.arn
  handler = "lambda.lambda_handler"

  runtime = "python3.7"

  environment {
      variables = {
        "MODE" = "DOWN"
      }
  }
}

resource "aws_cloudwatch_event_rule" "daily_trigger_8pm" {
  name                = "daily_trigger_8pm"
  description         = "Triggered once every day at 8PM SGT"
  schedule_expression = "cron(0 12 * * *)" # This will trigger at 8:00 PM SGT (12 PM UTC)
}

resource "aws_cloudwatch_event_target" "cluster_down" {
  rule      = aws_cloudwatch_event_rule.daily_trigger_8pm.name
  target_id = "cluster_down"
  arn       = aws_lambda_function.cluster_down.arn
}

# https://stackoverflow.com/questions/35895315/use-terraform-to-set-up-a-lambda-function-triggered-by-a-scheduled-event-source
resource "aws_lambda_permission" "allow_cloudwatch_to_call_check_foo" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.cluster_down.function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.daily_trigger_8pm.arn
}

# ###################################################################
# Role and permissions for lambda
# ###################################################################

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

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda.py"
  output_path = "lambda_function_payload.zip"
}
