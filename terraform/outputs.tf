## Saída da URL do API Gateway
#output "api_gateway_url" {
#  description = "URL do API Gateway"
#  value       = aws_api_gateway_rest_api.my_api.execution_arn
#}
#
## Saída do ID do Cognito User Pool
#output "cognito_user_pool_id" {
#  description = "ID do Cognito User Pool"
#  value       = aws_cognito_user_pool.user_pool.id
#}
# todo: entender necessidade de export algum output do api gateway