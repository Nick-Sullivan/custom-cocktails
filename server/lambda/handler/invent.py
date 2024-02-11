import json
import time
from typing import Dict

from domain_models.exceptions import InvalidRequestException
from domain_models.requests import InventRequest
from domain_models.validation import validate_request
from domain_services import prompter
from infrastructure import openai_interactor


def invent(event, context=None):
    print(event['body'])
    body = json.loads(event['body'])
    response = _invent(body)
    return {
        'statusCode': 200,
        'headers': { 'Content-Type': 'application/json'},
        'body': json.dumps(response),
    }


def _invent(request_body: Dict) -> Dict:
    start = time.time()

    print(f'{time.time() - start:.2f} Populating request')
    error_msgs = validate_request(request_body, InventRequest)
    if error_msgs:
        raise InvalidRequestException(json.dumps({'errors': error_msgs}))
    request = InventRequest(**request_body)
        
    print(f'{time.time() - start:.2f} Creating prompt')
    prompt = prompter.create(request)

    print(f'{time.time() - start:.2f} Sending prompt')
    recipe = openai_interactor.send(prompt)
    response_body = {
        'name': request.name,
        'recipe': recipe,
    }

    print(f'{time.time() - start:.2f} Complete')
    return response_body
