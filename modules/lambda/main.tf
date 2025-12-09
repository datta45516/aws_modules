terraform {
required_providers {
aws = {
source  = "hashicorp/aws"
version = "~> 5.0"
}
}
}
provider "aws" { region = var.region }

data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "${path.module}/${var.function_name}.zip"
  source {
    content  = var.source_code
    filename = "index.mjs"
  }
}

resource "aws_iam_role" "lambda" {
  name = "${var.function_name}-role"
     assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_lambda_function" "this" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = var.function_name
  role             = aws_iam_role.lambda.arn
  handler          = "index.handler"
  runtime          = var.runtime
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  environment {
    variables = var.environment_variables
  }
  tags = var.tags
}
