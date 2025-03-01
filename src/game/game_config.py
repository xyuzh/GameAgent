from typing import List

from pydantic import BaseModel, ConfigDict

from src.player.role import Role


class PlayerConfig(BaseModel):
    modelname: str
    role: Role


class GameConfig(BaseModel):
    model_config = ConfigDict(strict=True, frozen=True)

    players: List[PlayerConfig]
