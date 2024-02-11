

from dataclasses import asdict, dataclass
from typing import Dict, List


@dataclass
class Message:
    role: str
    content: str


@dataclass
class Prompt:
    model: str
    messages: List[Message]

    def to_dict(self) -> Dict:
        return asdict(self)
        