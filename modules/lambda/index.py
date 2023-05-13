import os
import json
import urllib.request

def lambda_handler(event, context):
    try:
        message = event['Records'][0]['Sns']['Message']
        slack_webhook_url = os.environ['SLACK_WEBHOOK_URL']
        formatted_message = f"New alarm triggered: \n> {json.dumps(json.loads(message), indent=2)}"
        slack_message = {
            'text': formatted_message
        }
        data = json.dumps(slack_message).encode('utf-8')
        headers = {'Content-Type': 'application/json'}
        req = urllib.request.Request(slack_webhook_url, data, headers)
        response = urllib.request.urlopen(req)
        return {'statusCode': 200, 'body': 'Message sent to Slack'}
    except Exception as e:
        return {'statusCode': 500, 'body': f'Error: {e}'}