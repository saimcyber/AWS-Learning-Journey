import json
from datetime import datetime

def lambda_handler(event, context):
    current_time = datetime.utcnow().isoformat()

    print("Scheduled Lambda executed")
    print(f"Current UTC time: {current_time}")

    return {
        "statusCode": 200,
        "body": json.dumps("Scheduled execution successful")
    }
