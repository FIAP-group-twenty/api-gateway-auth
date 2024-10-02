import json
import boto3

cognito_client = boto3.client('cognito-idp')


def lambda_handler(event, context):
    authorization_header = event.get('headers', {}).get('Authorization')

    if authorization_header:
        token = authorization_header.split(' ')[1]

        try:
            cognito_client.get_user(AccessToken=token)

            return {"statusCode": 200}

        except cognito_client.exceptions.NotAuthorizedException:
            return {
                "statusCode": 401,
                "body": json.dumps({"error": "Token inválido"})
            }

    return {
        "statusCode": 400,
        "body": json.dumps({"error": "Nenhum Authorization Token fornecido"})
    }
