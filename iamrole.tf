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


resource "aws_cloudwatch_log_group" "sandeep-logs" {
    name = "/aws/lambad/${aws_lambda_function.hello-sandeep-lambda.function_name}"
    retention_in_days = 14
}


data "archive_file" "lambda_hello" {
    type = "zip"
    source_dir = "input-file/function.js"
    output_dir = "output-zip/function.zip"
}


resource "aws_s3_object" "lambda_hello" {
    bucket = aws_s3_bucket.my-s3-day8-1.id
    key = function.zip
    source = data.archive_file.lambda_hello.output_path
    etag = file(data.archive_file.lambda_hello.output_path)
}







