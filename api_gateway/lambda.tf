resource "aws_lambda_function" "authorizer_lambda" {
  function_name    = "lambda_authorizer"
  handler          = "lambda_authorizer.lambda_handler"
  runtime          = "python3.9"
  role             = data.aws_iam_role.lambda_exec_role.arn
  filename         = "${path.module}/../lambda/lambda_authorizer.zip"
  source_code_hash = filebase64sha256("${path.module}/../lambda/lambda_authorizer.zip")

  environment {
    variables = {
      COGNITO_USER_POOL_ID = aws_cognito_user_pool.user_pool.id
    }
  }
}

resource "aws_api_gateway_authorizer" "jwt_lambda" {
  name                             = "LambdaAuthorizer"
  rest_api_id                      = aws_api_gateway_rest_api.tech_challenge.id
  authorizer_uri                   = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${aws_lambda_function.authorizer_lambda.arn}/invocations"
  authorizer_result_ttl_in_seconds = 300
  type                             = "REQUEST"
}

data "aws_iam_role" "lambda_exec_role" {
  name = "LambdaExecRole"
}

resource "aws_iam_role_policy" "lambda_policy" {
  role = data.aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect = "Allow",
        Action = [
          "lambda:InvokeFunction"
        ],
        Resource = aws_lambda_function.authorizer_lambda.arn
      },
      {
        Effect = "Allow",
        Action = [
          "cognito-idp:*"
        ],
        Resource = aws_cognito_user_pool.user_pool.arn
      }
    ]
  })
}

data "aws_caller_identity" "current" {}

resource "aws_lambda_permission" "allow_api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.authorizer_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.tech_challenge.id}/*"
}
