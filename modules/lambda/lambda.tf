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

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/index.py"
  output_path = "${path.module}/lambda_function_payload.zip"
}

resource "aws_lambda_function" "slack" {
  filename      = "${path.module}/lambda_function_payload.zip"
  function_name = "lambda_slack"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.lambda_handler"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime = "python3.9"

  environment {
    variables = {
      SLACK_WEBHOOK_URL = var.slack_webhook
    }
  }
}

resource "aws_lambda_permission" "with_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.slack.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = var.sns_topic
}
