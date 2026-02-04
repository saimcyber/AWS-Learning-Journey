import json

def lambda_handler(event, context):
    message = event["Records"][0]["Sns"]["Message"]

    print("SNS message received:")
    print(message)

    return {
        "statusCode": 200,
        "body": json.dumps("SNS message processed successfully")
    }
