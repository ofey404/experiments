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

module "lambda" {
  source = "./module"

  function_name = "cluster_down"
  source_dir = "./lambda"

  role_arn = aws_iam_role.iam_for_lambda.arn
  event_rule = aws_cloudwatch_event_rule.daily_trigger_8pm

  environment_variables = {
    "MODE" = "down"
    "FEISHU_APP_ID" = "cli_a4915737377d500c"
    "FEISHU_APP_SECRET" = "sqOOqtWk6A4pJx8ugJE9gdMsisQC5Sn0"
  }
}

resource "aws_cloudwatch_event_rule" "daily_trigger_8pm" {
  name                = "daily_trigger_8pm"
  description         = "Triggered once every day at 8PM SGT"
  schedule_expression = "cron(0 12 * * ? *)" # This will trigger at 8:00 PM SGT (12 PM UTC)
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

