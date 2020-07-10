module Monster.Monster exposing (allMonsterAct)

import Shape exposing (Rectangle,recCollisionTest,recInit,recUpdate)
import Map.Map exposing (Monster,MonsterType,Obstacle)



allMonsterAct:  List Monster -> Me  -> List Obstacle -> List Monster
allMonsterAct monsterList me obstacles = 
    List.map monsterAct monsterList me obstacles


