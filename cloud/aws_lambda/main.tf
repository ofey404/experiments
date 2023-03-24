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

  create_iam_role = true
  iam_role_name = "iam_for_lambda"
  iam_role_additional_policies = [
    "arn:aws:iam::662391098426:policy/AmazonEKSAdminPolicy"
  ]
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

