
from domain_models.prompt import Message, Prompt
from domain_models.requests import InventRequest


class Prompter:

    def create(self, request: InventRequest) -> Prompt:
        return Prompt(
            model="gpt-3.5-turbo",
            messages=[self._create_setup_message(), self._create_request_message(request)],
        )
    
    def _create_setup_message(self) -> Message:
        return Message(role="system", content="You are a cocktail mixologist writing a recipe book.")
    
    def _create_request_message(self, request: InventRequest) -> Message:
        content = "Create a cocktail recipe"
        if request.name:
            content += f" called {request.name}"
        if request.ingredients:
            content += f" with ingredients {request.ingredients}"
        content += "."
        if request.banned_ingredients:
            content += f" It must not contain the ingredients {request.banned_ingredients}"
        return Message(role="user", content=content)
        