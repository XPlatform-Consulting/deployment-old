resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "iam_policy_for_lambda" {
  name = "${var.lambda_function_name}"
  policy = "${var.iam_policy_document}"
  role = "${aws_iam_role.iam_for_lambda.id}"
}

resource "aws_lambda_function" "lambda" {
  filename         = "${var.lambda_function_payload}"
  function_name    = "${var.lambda_function_name}"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "${var.lambda_function_handler}"
  source_code_hash = "${base64sha256(file("${var.lambda_function_payload}"))}"
  runtime          = "${var.lambda_function_runtime}"

  environment = ["${slice( list(var.environment), 0, length(var.environment) == 0 ? 0 : 1 )}"]
}
