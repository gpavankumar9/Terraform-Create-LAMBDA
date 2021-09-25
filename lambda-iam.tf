resource "aws_iam_role_policy" "lambda_policy" {
  name = "test_policy"
  role = aws_iam_role.lambda_role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = "${file("Iam/iam-policy.json")}"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  assume_role_policy = "${file("Iam/lambda-assume-policy.json")}"
}