
import json
import sys

from dotenv import load_dotenv

sys.path.append('lambda/')
sys.path.append('lambda/handler')
sys.path.append('lambda/layer/python/')

from invent import invent


def main():
    request = {
        "name": "Nicks Love",
        "ingredients": "hot sauce",
        "banned_ingredients": "",
    }
    response = invent({'body': json.dumps(request)})
    print(response)


if __name__ == '__main__':
    load_dotenv()
    main()
