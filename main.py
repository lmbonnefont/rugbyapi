from typing import List

from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session

import crud
import models
import schemas
from database import SessionLocal, engine

models.Base.metadata.create_all(bind=engine)


app = FastAPI()

# Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get("/players/", response_model=List[schemas.Player])
def read_users(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    players = crud.get_players(db, skip=skip, limit=limit)
    return players


@app.post("/players/", response_model=schemas.Player)
def create_user(player: schemas.Player, db: Session = Depends(get_db)):
    print(crud.create_player(db=db, player=player))
