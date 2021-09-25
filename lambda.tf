locals {
    lambda_zip_location = "$outputs/appzip.zip"
}
provider "aws" {
  region     = "us-east-1"

}

data "archive_file" "appzip" {
  type        = "zip"
  source_file = "app.py"
  output_path = "${local.lambda_zip_location}"
}

resource "aws_lambda_function" "test_lambda" {
  filename      = "${local.lambda_zip_location}"
  function_name = "lambda_function_terraform"
  role          = "${aws_iam_role.lambda_role.arn}"
  handler       = "app.lambda_handler"
    #this hash will check the zip file if any code change and then deploy.Otherwise deploy will not reflect the new changes
  source_code_hash = "${filebase64sha256(local.lambda_zip_location)}"

  runtime = "python3.8"

  environment {
    variables = {
      greeting = "welcome"
    }
  }
}