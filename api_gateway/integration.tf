###################### CUSTOMER ######################

resource "aws_api_gateway_integration" "customer_create_integration" {
  rest_api_id             = aws_api_gateway_rest_api.tech_challenge.id
  resource_id             = aws_api_gateway_resource.customer_resource.id
  http_method             = aws_api_gateway_method.customer_post_method.http_method
  integration_http_method = "POST"
  type                    = "HTTP"
  uri                     = "https://backend.example.com/v1/customer" //todo: definir
}

resource "aws_api_gateway_integration" "customer_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.tech_challenge.id
  resource_id             = aws_api_gateway_resource.customer_get_resource.id
  http_method             = aws_api_gateway_method.customer_get_by_cpf_method.http_method
  integration_http_method = "GET"
  type                    = "HTTP"
  uri                     = "https://backend.example.com/v1/customer/{cpf}" //todo: definir
}

###################### ORDER ######################