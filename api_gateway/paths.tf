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