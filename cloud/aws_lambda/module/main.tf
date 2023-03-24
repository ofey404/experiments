resource "aws_lambda_function" "this" {
  filename      = data.archive_file.this.output_path
  source_code_hash = data.archive_file.this.output_base64sha256

  function_name = var.function_name
  role          = var.role_arn
  handler = var.handler

  runtime = var.runtime

  environment {
      variables =  var.environment_variables
  }
}

resource "aws_cloudwatch_event_target" "this" {
  rule      = var.event_rule.name
  target_id = aws_lambda_function.this.function_name
  arn       = aws_lambda_function.this.arn
}

# https://stackoverflow.com/questions/35895315/use-terraform-to-set-up-a-lambda-function-triggered-by-a-scheduled-event-source
resource "aws_lambda_permission" "allow_cloudwatch_to_call_check_foo" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.this.function_name
    principal = "events.amazonaws.com"
    source_arn = var.event_rule.arn
}


data "archive_file" "this" {
  type        = "zip"
  source_dir = var.source_dir
  output_path = "lambda_function_payload.zip"
}

