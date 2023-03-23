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
        "FEISHU_APP_ID" = "cli_a4915737377d500c"
        "FEISHU_APP_SECRET" = "sqOOqtWk6A4pJx8ugJE9gdMsisQC5Sn0"
      }
  }
}

resource "aws_cloudwatch_event_rule" "daily_trigger_8pm" {
  name                = "daily_trigger_8pm"
  description         = "Triggered once every day at 8PM SGT"
  schedule_expression = "cron(0 12 * * ? *)" # This will trigger at 8:00 PM SGT (12 PM UTC)
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
