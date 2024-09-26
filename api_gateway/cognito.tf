## Criação do Cognito User Pool
#resource "aws_cognito_user_pool" "user_pool" {
#  name = "meu-user-pool"
#}
#
## Configuração de um cliente para o User Pool
#resource "aws_cognito_user_pool_client" "user_pool_client" {
#  user_pool_id = aws_cognito_user_pool.user_pool.id
#  name         = "meu-app-client"
#  generate_secret = false
#}
# todo: fazer isso aq kk