resource "aws_lambda_function" "this" {
  filename      = data.archive_file.this.output_path
  source_code_hash = data.archive_file.this.output_base64sha256

  function_name = var.function_name
  role          = var.create_iam_role ? aws_iam_role.this[0].arn : var.iam_role_arn
  handler = var.handler

  runtime = var.runtime
  timeout = var.timeout

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
resource "aws_lambda_permission" "allow_cloudwatch_to_call_function" {
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

################################################################################
# Create IAM Role If Not Provided
################################################################################

resource "aws_iam_role" "this" {
  count = var.create_iam_role ? 1 : 0

  name               = var.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role[0].json
}

data "aws_iam_policy_document" "assume_role" {
  count = var.create_iam_role ? 1 : 0

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
  count = var.create_iam_role ? 1 : 0

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.this[0].name
}

resource "aws_iam_role_policy_attachment" "additional" {
  for_each = toset(var.iam_role_additional_policies)

  policy_arn = each.key
  role       = aws_iam_role.this[0].name
}