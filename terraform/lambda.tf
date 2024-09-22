resource "aws_lambda_function" "authorizer_lambda" { #todo: melhorar esse nome
  function_name = "AuthorizerLambda"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  #todo: verificar necessidade de criar essa role manualmente pelo iam
  role          = aws_iam_role.lambda_exec_role.arn
  filename      = "${path.module}/lambda/lambda_authorizer.zip" #todo: isso aq ta certo?

  environment {
    variables = {
      COGNITO_USER_POOL_ID = aws_cognito_user_pool.user_pool.id #todo: resolver isso aq
    }
  }
}

resource "aws_lambda_function" "validate_lambda" { #todo: melhorar esse nome
  function_name = "ValidateLambda"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  #todo: verificar necessidade de criar essa role manualmente pelo iam
  role          = aws_iam_role.lambda_exec_role.arn
  filename      = "${path.module}/lambda/lambda_validate.zip" #todo: criar esse aq

  environment {
    variables = {
      COGNITO_USER_POOL_ID = aws_cognito_user_pool.user_pool.id #todo: resolver isso aq
    }
  }
}

# todo: validar se essa configuração da role é o suficiente
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
