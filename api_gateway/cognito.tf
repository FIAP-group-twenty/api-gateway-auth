resource "aws_cognito_user_pool" "user_pool" {
  name = "tech-challenge-user-pool"
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  user_pool_id = aws_cognito_user_pool.user_pool.id
  name         = "tech-challenge-client"
  generate_secret = false
}