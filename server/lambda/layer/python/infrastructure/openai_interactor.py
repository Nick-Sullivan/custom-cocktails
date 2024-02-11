
from domain_models.prompt import Prompt


class OpenAiInteractor:

    def __init__(self, client):
        self.client = client

    def send(self, prompt: Prompt) -> str:
        stream = self.client.chat.completions.create(**prompt.to_dict(), stream=True)
        responses = []
        for chunk in stream:
            if chunk.choices[0].delta.content is not None:
                new = chunk.choices[0].delta.content
                # print(new, end="")
                responses.append(new)
            
        return "".join(responses)
        # return completion.choices[0].message.content
