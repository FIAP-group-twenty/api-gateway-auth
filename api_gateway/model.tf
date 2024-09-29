# Necessário para a criação do JWT pelo cognito
#resource "aws_api_gateway_model" "customer_model" {
#  rest_api_id  = aws_api_gateway_rest_api.tech_challenge.id
#  content_type = "application/json"
#  name         = "CustomerModel"
#  schema       = jsonencode({
#    type       = "object",
#    properties = {
#      name  = { type = "string" },
#      email = { type = "string" },
#      cpf   = { type = "string" }
#    },
#    required = ["cpf"]
#  })
#}