import json
import boto3


def lambda_handler(event, context):
    cpf = event['headers'].get('cpf')
    if not cpf or not validate_cpf(cpf):
        return {
            "statusCode": 403,
            "body": json.dumps("Unauthorized")
        }

    client = boto3.client('cognito-idp')
    response = client.admin_get_user(
        UserPoolId='us-east-1_Example',
        Username=cpf
    )

    # todo: validar como vamos fazer a autenticação do usuário, bater no banco e procurar por cadastro?
    #  aceitar quando só o cpf for informado?

    if 'UserStatus' in response and response['UserStatus'] == 'CONFIRMED':
        return generate_policy('user', 'Allow', event['methodArn'])
    else:
        return {
            "statusCode": 403,
            "body": json.dumps("Unauthorized")
        }


def generate_policy(principal_id, effect, resource):
    auth_response = {'principalId': principal_id}
    if effect and resource:
        policy_document = {
            'Version': '2012-10-17',
            'Statement': [{
                'Action': 'execute-api:Invoke',
                'Effect': effect,
                'Resource': resource
            }]
        }
        auth_response['policyDocument'] = policy_document
    return auth_response
