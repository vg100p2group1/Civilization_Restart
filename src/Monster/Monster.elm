module Monster.Monster exposing (allMonsterAct)

import Shape exposing (Rectangle,recCollisionTest,recInit,recUpdate)
import Map.Map exposing (Monster,MonsterType,Obstacle)
import Model exposing (..)
import Weapon exposing (..)


allMonsterAct:  List Monster -> Me  -> List Obstacle -> List Bullet -> (List Monster,List Bullet)
allMonsterAct monsterList me obstacles bulletList = 
    let 

        newMonsterList = List.map (monsterAct me obstacles)  monsterList

        newBulletList = monsterShoot newMonsterList me obstacles bulletList

    in
        (newMonsterList,newBulletList)

monsterAct :  Me  -> List Obstacle -> Monster ->  Monster
monsterAct  me obstacles monster= 
    monster

monsterShoot : List Monster -> Me  -> List Obstacle-> List Bullet -> List Bullet
monsterShoot newMonsterList me obstacles bulletList = 
    bulletList


