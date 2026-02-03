import json
import boto3
import urllib.parse

s3 = boto3.client("s3")

def lambda_handler(event, context):
    record = event["Records"][0]
    bucket_name = record["s3"]["bucket"]["name"]
    object_key = urllib.parse.unquote_plus(
        record["s3"]["object"]["key"]
    )

    print(f"New file uploaded: {object_key} in bucket: {bucket_name}")

    destination_key = f"processed/{object_key}"

    s3.copy_object(
        Bucket=bucket_name,
        CopySource={
            "Bucket": bucket_name,
            "Key": object_key
        },
        Key=destination_key
    )

    print(f"File copied to {destination_key}")

    return {
        "statusCode": 200,
        "body": json.dumps("File processed successfully")
    }
