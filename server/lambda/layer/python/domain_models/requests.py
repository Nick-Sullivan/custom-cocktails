from dataclasses import dataclass


@dataclass
class InventRequest:
    name: str
    ingredients: str
    banned_ingredients: str
