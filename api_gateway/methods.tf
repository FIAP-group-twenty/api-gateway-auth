###################### CUSTOMER ######################

resource "aws_api_gateway_method" "customer_post_method" {
  rest_api_id   = aws_api_gateway_rest_api.tech_challenge.id
  resource_id   = aws_api_gateway_resource.customer_resource.id
  http_method   = "POST"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.jwt_lambda.id

  request_models = {
    "application/json" = aws_api_gateway_model.customer_model.id
  }
}

resource "aws_api_gateway_method" "customer_get_by_cpf_method" {
  rest_api_id   = aws_api_gateway_rest_api.tech_challenge.id
  resource_id   = aws_api_gateway_resource.customer_get_resource.id
  http_method   = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.jwt_lambda.id
}

###################### ORDER ######################