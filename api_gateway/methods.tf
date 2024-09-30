###################### CUSTOMER ######################
resource "aws_api_gateway_method" "customer_post_method" {
  rest_api_id   = aws_api_gateway_rest_api.tech_challenge.id
  resource_id   = aws_api_gateway_resource.customer_resource.id
  http_method   = "POST"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.jwt_lambda.id
}

resource "aws_api_gateway_method" "customer_get_by_cpf_method" {
  rest_api_id   = aws_api_gateway_rest_api.tech_challenge.id
  resource_id   = aws_api_gateway_resource.customer_get_resource.id
  http_method   = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.jwt_lambda.id
}

###################### ORDER ######################
resource "aws_api_gateway_method" "order_create_method" {
  rest_api_id   = aws_api_gateway_rest_api.tech_challenge.id
  resource_id   = aws_api_gateway_resource.order_resource.id
  http_method   = "POST"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.jwt_lambda.id
}

resource "aws_api_gateway_method" "order_list_method" {
  rest_api_id   = aws_api_gateway_rest_api.tech_challenge.id
  resource_id   = aws_api_gateway_resource.order_resource.id
  http_method   = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.jwt_lambda.id
}

resource "aws_api_gateway_method" "order_put_method" {
  rest_api_id   = aws_api_gateway_rest_api.tech_challenge.id
  resource_id   = aws_api_gateway_resource.order_put_resource.id
  http_method   = "PUT"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.jwt_lambda.id
}

###################### PAYMENT ######################
resource "aws_api_gateway_method" "payment_webhook_method" {
  rest_api_id   = aws_api_gateway_rest_api.tech_challenge.id
  resource_id   = aws_api_gateway_resource.payment_webhook_resource.id
  http_method   = "PUT"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.jwt_lambda.id
}

resource "aws_api_gateway_method" "payment_get_method" {
  rest_api_id   = aws_api_gateway_rest_api.tech_challenge.id
  resource_id   = aws_api_gateway_resource.payment_get_resource.id
  http_method   = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.jwt_lambda.id
}

###################### PRODUCT ######################