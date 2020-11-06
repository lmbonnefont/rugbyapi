from typing import Optional

from pydantic import BaseModel

class Player(BaseModel):
    name: str
    surname: str
    age: int
    height: int
    weight: int
    position: str
    nationality: str
    games: Optional[int] = None
    number_of_try: Optional[int] = None
    season: int

    class Config:
        orm_mode = True
