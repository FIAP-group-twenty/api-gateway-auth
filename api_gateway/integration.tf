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
resource "aws_api_gateway_integration" "order_create_integration" {
  rest_api_id             = aws_api_gateway_rest_api.tech_challenge.id
  resource_id             = aws_api_gateway_resource.order_resource.id
  http_method             = aws_api_gateway_method.order_create_method.http_method
  integration_http_method = "POST"
  type                    = "HTTP"
  uri                     = "https://backend.example.com/v1/order" //todo: definir
}

resource "aws_api_gateway_integration" "order_list_integration" {
  rest_api_id             = aws_api_gateway_rest_api.tech_challenge.id
  resource_id             = aws_api_gateway_resource.order_resource.id
  http_method             = aws_api_gateway_method.order_list_method.http_method
  integration_http_method = "GET"
  type                    = "HTTP"
  uri                     = "https://backend.example.com/v1/order" //todo: definir
}

resource "aws_api_gateway_integration" "order_put_integration" {
  rest_api_id             = aws_api_gateway_rest_api.tech_challenge.id
  resource_id             = aws_api_gateway_resource.order_put_resource.id
  http_method             = aws_api_gateway_method.order_put_method.http_method
  integration_http_method = "PUT"
  type                    = "HTTP"
  uri                     = "https://backend.example.com/v1/order/{id}" //todo: definir
}

###################### PAYMENT ######################
resource "aws_api_gateway_integration" "payment_webhook_integration" {
  rest_api_id             = aws_api_gateway_rest_api.tech_challenge.id
  resource_id             = aws_api_gateway_resource.payment_webhook_resource.id
  http_method             = aws_api_gateway_method.payment_webhook_method.http_method
  integration_http_method = "PUT"
  type                    = "HTTP"
  uri                     = "https://backend.example.com/v1/payment/webhook" //todo: definir
}

resource "aws_api_gateway_integration" "payment_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.tech_challenge.id
  resource_id             = aws_api_gateway_resource.payment_get_resource.id
  http_method             = aws_api_gateway_method.payment_get_method.http_method
  integration_http_method = "GET"
  type                    = "HTTP"
  uri                     = "https://backend.example.com/v1/payment/status/{orderId}" //todo: definir
}

###################### PRODUCT ######################