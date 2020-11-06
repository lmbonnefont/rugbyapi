from sqlalchemy.orm import Session

import models
import schemas


def get_players(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.Player).order_by(models.Player.number_of_try.desc()).offset(skip).limit(limit).all()

def create_player(db: Session, player: schemas.Player):
    db_player = models.Player(name=player.name, surname=player.surname, age=player.age, height=player.height, weight=player.weight, position=player.position, nationality=player.nationality, games=player.games, number_of_try=player.number_of_try, season=player.season)
    db.add(db_player)
    db.commit()
    db.refresh(db_player)
    return db_player
