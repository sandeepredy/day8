resource "aws_iam_role" "day8-role-1" {
  name = "day8-role-1"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "day8-role-1"
  }
}


resource "aws_iam_role_policy_attachment" "day8-role-1" {
  role       = aws_iam_role.day8-role-1.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


resource "aws_lambda_function" "hello-sandeep-lambda" {
  function_name = "hello-sandeep-lambda"
  s3_bucket     = aws_s3_bucket.my-s3-day8-1.id
  s3_key        = aws_s3_bicket.my-s3-day8-1.s3_key

  runtime = "nodejs16.x"
  handler = "function.handler"

  source_code_bash = data.archive_file.lambda_hello.output_base64sha256

  role = aws_iam_role.day8-role-1.arn

}




