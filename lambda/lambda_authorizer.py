import json
import re
import boto3
import jwt
from datetime import datetime, timezone

cognito_client = boto3.client('cognito-idp')


def validar_token_expirado(token):
    try:
        decoded_token = jwt.decode(token, options={"verify_signature": False})
        exp = decoded_token.get('exp')
        if exp is None:
            return False
        if datetime.fromtimestamp(exp, timezone.utc) < datetime.now(timezone.utc):
            return True
        return False
    except jwt.ExpiredSignatureError:
        return True
    except jwt.InvalidTokenError:
        return True


def verificar_cpf_existente(cpf, user_pool_id):
    try:
        # Tenta listar usuários filtrando pelo CPF
        response = cognito_client.list_users(
            UserPoolId=user_pool_id,
            Filter=f'username = "{cpf}"'
        )
        # Se encontrar algum usuário, o CPF já existe
        if response['Users']:
            return True
        return False
    except Exception as e:
        print(f"Erro ao verificar CPF: {e}")
        return False


def validar_cpf(cpf):
    pattern = r'^\d{11}$'
    return re.match(pattern, cpf) is not None


def lambda_handler(event, context):
    authorization_header = event.get('headers', {}).get('Authorization')
    cpf = event.get('cpf')
    user_pool_id = 'seu-user-pool-id'
    client_id = 'seu-client-id'

    if cpf:
        if not validar_cpf(cpf):
            return {
                "statusCode": 400,
                "body": json.dumps({"error": "Formato de CPF inválido"})
            }

        if verificar_cpf_existente(cpf, user_pool_id):
            return {
                "statusCode": 400,
                "body": json.dumps({"error": "CPF já cadastrado"})
            }

        try:
            response = cognito_client.admin_initiate_auth(
                UserPoolId=user_pool_id,
                ClientId=client_id,
                AuthFlow='CUSTOM_AUTH',
                AuthParameters={
                    'USERNAME': cpf
                }
            )
            jwt_token = response['AuthenticationResult']['IdToken']

            return {
                "statusCode": 200,
                "body": json.dumps({"token": jwt_token})
            }

        except cognito_client.exceptions.NotAuthorizedException:
            return {
                "statusCode": 401,
                "body": json.dumps({"error": "Usuário não autorizado"})
            }

    elif authorization_header:
        token = authorization_header.split(' ')[1]

        if validar_token_expirado(token):
            return {
                "statusCode": 401,
                "body": json.dumps({"error": "Token expirado"})
            }

        try:
            response = cognito_client.get_user(
                AccessToken=token
            )
            cpf = response['Username']

            return {
                "statusCode": 200,
                "body": json.dumps({"cpf": cpf})  # todo: validar com o grupo, isso pode ser um problema
            }

        except cognito_client.exceptions.NotAuthorizedException:
            return {
                "statusCode": 401,
                "body": json.dumps({"error": "Token inválido"})
            }

    return {
        "statusCode": 400,
        "body": json.dumps({"error": "Nenhum CPF ou Authorization fornecido"})
    }
