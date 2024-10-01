###################### CUSTOMER ######################
resource "aws_api_gateway_resource" "customer_resource" {
  rest_api_id = aws_api_gateway_rest_api.tech_challenge.id
  parent_id   = aws_api_gateway_rest_api.tech_challenge.root_resource_id
  path_part   = var.customer_path
}

resource "aws_api_gateway_resource" "customer_get_resource" {
  rest_api_id = aws_api_gateway_rest_api.tech_challenge.id
  parent_id   = aws_api_gateway_resource.customer_resource.id
  path_part   = var.customer_get_path
}

###################### ORDER ######################
resource "aws_api_gateway_resource" "order_resource" {
  rest_api_id = aws_api_gateway_rest_api.tech_challenge.id
  parent_id   = aws_api_gateway_rest_api.tech_challenge.root_resource_id
  path_part   = var.order_path
}

resource "aws_api_gateway_resource" "order_put_resource" {
  rest_api_id = aws_api_gateway_rest_api.tech_challenge.id
  parent_id   = aws_api_gateway_resource.order_resource.id
  path_part   = var.order_update_path
}

###################### PAYMENT ######################
resource "aws_api_gateway_resource" "payment_webhook_resource" {
  rest_api_id = aws_api_gateway_rest_api.tech_challenge.id
  parent_id   = aws_api_gateway_rest_api.tech_challenge.root_resource_id
  path_part   = var.webhook_path
}

resource "aws_api_gateway_resource" "payment_get_resource" {
  rest_api_id = aws_api_gateway_rest_api.tech_challenge.id
  parent_id   = aws_api_gateway_rest_api.tech_challenge.root_resource_id
  path_part   = var.payment_get_path
}

###################### PRODUCT ######################
resource "aws_api_gateway_resource" "product_resource" {
  rest_api_id = aws_api_gateway_rest_api.tech_challenge.id
  parent_id   = aws_api_gateway_rest_api.tech_challenge.root_resource_id
  path_part   = var.product_path
}

resource "aws_api_gateway_resource" "product_get_resource" {
  rest_api_id = aws_api_gateway_rest_api.tech_challenge.id
  parent_id   = aws_api_gateway_resource.product_resource.id
  path_part   = var.product_get_path
}

resource "aws_api_gateway_resource" "product_put_or_delete_resource" {
  rest_api_id = aws_api_gateway_rest_api.tech_challenge.id
  parent_id   = aws_api_gateway_resource.product_resource.id
  path_part   = var.product_put_or_delete_path
}