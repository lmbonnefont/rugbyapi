from sqlalchemy import Column, String, Integer

from database import Base

class Player(Base):
    __tablename__ = "players"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    surname = Column(String)
    age = Column(Integer, index=True)
    height = Column(Integer, index=True)
    weight = Column(Integer, index=True)
    position = Column(String, index=True)
    nationality = Column(String, index=True)
    games = Column(String, index=True)
    number_of_try = Column(Integer, index=True)
    season = Column(Integer, index=True)