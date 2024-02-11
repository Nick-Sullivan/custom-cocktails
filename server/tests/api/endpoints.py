
import json
import os

import requests

base_url = os.environ['API_GATEWAY_URL']


def _post(endpoint, data):
    return requests.request(
        'POST',
        f'{base_url}/{endpoint}',
        data=json.dumps(data))


def invent(request):
    return _post('invent', request)
