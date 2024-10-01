###################### CUSTOMER ######################
resource "aws_api_gateway_integration" "customer_create_integration" {
  rest_api_id             = aws_api_gateway_rest_api.tech_challenge.id
  resource_id             = aws_api_gateway_resource.customer_resource.id
  http_method             = aws_api_gateway_method.customer_post_method.http_method
  integration_http_method = "POST"
  type                    = "HTTP"
  uri                     = "http://ec2-44-203-35-124.compute-1.amazonaws.com:30005/v1/customer"
}

resource "aws_api_gateway_integration" "customer_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.tech_challenge.id
  resource_id             = aws_api_gateway_resource.customer_get_resource.id
  http_method             = aws_api_gateway_method.customer_get_by_cpf_method.http_method
  integration_http_method = "GET"
  type                    = "HTTP"
  uri                     = "http://ec2-44-203-35-124.compute-1.amazonaws.com:30005/v1/customer/{cpf}"
}

###################### ORDER ######################
resource "aws_api_gateway_integration" "order_create_integration" {
  rest_api_id             = aws_api_gateway_rest_api.tech_challenge.id
  resource_id             = aws_api_gateway_resource.order_resource.id
  http_method             = aws_api_gateway_method.order_create_method.http_method
  integration_http_method = "POST"
  type                    = "HTTP"
  uri                     = "http://ec2-44-203-35-124.compute-1.amazonaws.com:30005/v1/order"
}

resource "aws_api_gateway_integration" "order_list_integration" {
  rest_api_id             = aws_api_gateway_rest_api.tech_challenge.id
  resource_id             = aws_api_gateway_resource.order_resource.id
  http_method             = aws_api_gateway_method.order_list_method.http_method
  integration_http_method = "GET"
  type                    = "HTTP"
  uri                     = "http://ec2-44-203-35-124.compute-1.amazonaws.com:30005/v1/order"
}

resource "aws_api_gateway_integration" "order_put_integration" {
  rest_api_id             = aws_api_gateway_rest_api.tech_challenge.id
  resource_id             = aws_api_gateway_resource.order_put_resource.id
  http_method             = aws_api_gateway_method.order_put_method.http_method
  integration_http_method = "PUT"
  type                    = "HTTP"
  uri                     = "http://ec2-44-203-35-124.compute-1.amazonaws.com:30005/v1/order/{id}"
}

###################### PAYMENT ######################
resource "aws_api_gateway_integration" "payment_webhook_integration" {
  rest_api_id             = aws_api_gateway_rest_api.tech_challenge.id
  resource_id             = aws_api_gateway_resource.payment_webhook_resource.id
  http_method             = aws_api_gateway_method.payment_webhook_method.http_method
  integration_http_method = "PUT"
  type                    = "HTTP"
  uri                     = "http://ec2-44-203-35-124.compute-1.amazonaws.com:30005/v1/payment/webhook"
}

resource "aws_api_gateway_integration" "payment_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.tech_challenge.id
  resource_id             = aws_api_gateway_resource.payment_get_resource.id
  http_method             = aws_api_gateway_method.payment_get_method.http_method
  integration_http_method = "GET"
  type                    = "HTTP"
  uri                     = "http://ec2-44-203-35-124.compute-1.amazonaws.com:30005/v1/payment/status/{orderId}"
}

###################### PRODUCT ######################
resource "aws_api_gateway_integration" "product_create_integration" {
  rest_api_id             = aws_api_gateway_rest_api.tech_challenge.id
  resource_id             = aws_api_gateway_resource.product_resource.id
  http_method             = aws_api_gateway_method.product_create_method.http_method
  integration_http_method = "POST"
  type                    = "HTTP"
  uri                     = "http://ec2-44-203-35-124.compute-1.amazonaws.com:30005/v1/order"
}

resource "aws_api_gateway_integration" "product_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.tech_challenge.id
  resource_id             = aws_api_gateway_resource.product_get_resource.id
  http_method             = aws_api_gateway_method.product_get_method.http_method
  integration_http_method = "GET"
  type                    = "HTTP"
  uri                     = "http://ec2-44-203-35-124.compute-1.amazonaws.com:30005/v1/order"
}

resource "aws_api_gateway_integration" "product_put_integration" {
  rest_api_id             = aws_api_gateway_rest_api.tech_challenge.id
  resource_id             = aws_api_gateway_resource.product_put_or_delete_resource.id
  http_method             = aws_api_gateway_method.product_put_method.http_method
  integration_http_method = "PUT"
  type                    = "HTTP"
  uri                     = "http://ec2-44-203-35-124.compute-1.amazonaws.com:30005/v1/order/{id}"
}

resource "aws_api_gateway_integration" "product_delete_integration" {
  rest_api_id             = aws_api_gateway_rest_api.tech_challenge.id
  resource_id             = aws_api_gateway_resource.product_put_or_delete_resource.id
  http_method             = aws_api_gateway_method.product_delete_method.http_method
  integration_http_method = "DELETE"
  type                    = "HTTP"
  uri                     = "http://ec2-44-203-35-124.compute-1.amazonaws.com:30005/v1/order/{id}"
}