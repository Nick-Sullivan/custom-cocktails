
import os

from dotenv import load_dotenv
from openai import OpenAI


def main():
    name = "Spaghetti Western"
    ingredients = "gin, vodka"
    must_not_have = "lemon"
    message = "Create a cocktail recipe"
    if name:
        message += f" called {name}"
    if ingredients:
        message += f" with ingredients {ingredients}"
    message += "."
    if must_not_have:
        message += f" It must not contain the ingredients {must_not_have}"

    result = send_request(message)

    print(result)

def send_request(message: str) -> str:
    client = OpenAI(api_key=os.environ['OPEN_AI_KEY'])

    completion = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=[
            {"role": "system", "content": "You are a cocktail mixologist writing a recipe book."},
            {"role": "user", "content": message}
        ]
    )
    return completion.choices[0].message.content

if __name__ == '__main__':
    load_dotenv()
    main()
