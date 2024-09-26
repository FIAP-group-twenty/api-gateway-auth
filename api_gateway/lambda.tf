resource "aws_lambda_function" "authorizer_lambda" {
  function_name = "AuthorizerLambda"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  role          = aws_iam_role.lambda_exec_role.arn
  filename      = "${path.module}/lambda/lambda_authorizer.zip"

  environment {
    variables = {
      COGNITO_USER_POOL_ID = aws_cognito_user_pool.user_pool.id #todo: resolver isso aq
    }
  }
}

resource "aws_api_gateway_authorizer" "jwt_lambda" {
  name                   = "LambdaAuthorizer"
  rest_api_id            = aws_api_gateway_rest_api.tech_challenge.id
  authorizer_uri         = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${aws_lambda_function.authorizer_lambda.arn}/invocations"
  authorizer_result_ttl_in_seconds = 300
  type                   = "REQUEST"
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "LambdaExecRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect   = "Allow",
        Action   = [
          "lambda:InvokeFunction"
        ],
        Resource = "*"
      },
      {
        Effect   = "Allow",
        Action   = [
          "cognito-idp:*"
        ],
        Resource = aws_cognito_user_pool.user_pool.arn
      }
    ]
  })
}

