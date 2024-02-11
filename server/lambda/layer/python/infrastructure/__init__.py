import os

from openai import OpenAI

from .openai_interactor import OpenAiInteractor

openai_interactor = OpenAiInteractor(OpenAI(api_key=os.environ['OPEN_AI_KEY']))
