# API GATEWAY
resource "aws_api_gateway_rest_api" "tech_challenge" {
  name = "TechChallenge"
}

# PATH todo: criar os paths de todos os endpoints da API e talvez separar em outros arquivos
resource "aws_api_gateway_resource" "customer_resource" {
  rest_api_id = aws_api_gateway_rest_api.tech_challenge.id
  parent_id   = aws_api_gateway_rest_api.tech_challenge.root_resource_id
  path_part   = "customer" #todo: colocar em variables.tf e descobrir qual vai ser com o eks
}

resource "aws_api_gateway_resource" "customer_get_resource" { # todo: é necessario esse resource?
  rest_api_id = aws_api_gateway_rest_api.tech_challenge.id
  parent_id   = aws_api_gateway_rest_api.tech_challenge.root_resource_id
  path_part   = "customer/{CPF}" #todo: colocar em variables.tf
}

# METHOD todo: criar os methods de todos os endpoints da API e talvez separar em outros arquivos
resource "aws_api_gateway_method" "customer_post_method" {
  rest_api_id   = aws_api_gateway_rest_api.tech_challenge.id
  resource_id   = aws_api_gateway_resource.customer_resource.id
  http_method   = "POST"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.create_jwt_lambda.id
}

resource "aws_api_gateway_method" "customer_get_by_cpf_method" {
  rest_api_id   = aws_api_gateway_rest_api.tech_challenge.id
  resource_id   = aws_api_gateway_resource.customer_get_resource.id
  http_method   = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.jwt_authorizer.id
}

# INTEGRATION todo: criar os integrations de todos os endpoints da API apontando para validação do JWT e apenas a roda /auth para o authorizer
#todo: talvez separar em outros arquivos
resource "aws_api_gateway_integration" "customer_create_integration" {
  rest_api_id             = aws_api_gateway_rest_api.tech_challenge.id
  resource_id             = aws_api_gateway_resource.customer_resource.id
  http_method             = aws_api_gateway_method.customer_post_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.authorizer_lambda.invoke_arn
}

resource "aws_api_gateway_integration" "customer_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.tech_challenge.id
  resource_id             = aws_api_gateway_resource.customer_get_resource.id
  http_method             = aws_api_gateway_method.customer_get_by_cpf_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.validate_lambda.invoke_arn
}

# Lambda Authorizer para criar o JWT
resource "aws_api_gateway_authorizer" "create_jwt_lambda" {
  name                   = "LambdaAuthorizer"
  rest_api_id            = aws_api_gateway_rest_api.tech_challenge.id
  authorizer_uri         = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${aws_lambda_function.authorizer_lambda.arn}/invocations"
  authorizer_result_ttl_in_seconds = 300
  type                   = "REQUEST"
}

# Lambda Authorizer para validar o JWT
resource "aws_api_gateway_authorizer" "jwt_authorizer" {
  name                   = "JWTAuthorizer"
  rest_api_id            = aws_api_gateway_rest_api.tech_challenge.id
  authorizer_uri         = aws_lambda_function.validate_lambda.invoke_arn
  authorizer_result_ttl_in_seconds = 300
  identity_source        = "method.request.header.Authorization"
  type                   = "TOKEN"
}
