module Monster.Monster exposing (allMonsterAct)

import Shape exposing (Rectangle,recCollisionTest,recInit,recUpdate)
import Map.Map exposing (Monster,MonsterType,Obstacle)
import Model exposing (..)
import Weapon exposing (..)
import Random exposing (..)


allMonsterAct:  List Monster -> Me  -> List Rectangle -> List Bullet -> (List Monster,List Bullet)
allMonsterAct monsterList me obstacles bulletList = 
    let 

        newMonsterList = List.map  monsterAct  monsterList

        newBulletList = monsterShoot newMonsterList me obstacles bulletList

    in
        (newMonsterList,newBulletList)

monsterAct :  Monster ->  Monster
monsterAct  monster= 
    let 
        numtodir num = 
            (3*(sin (degrees <|toFloat num)),3*(cos (degrees <|toFloat num))  )

        (directiondiff,seed1) =  Random.step (Random.int -30 30) monster.seed
        
        nowdir = monster.direction

        newdir = nowdir + directiondiff

        direction = numtodir newdir

        nowPos = (monster.position.cx , monster.position.cy)

        region = (monster.region.edge.cx , monster.region.edge.cy)

        difference = monster.region.edge.halfWidth - monster.position.r

        checkfeasible pos reg diff= 
            (abs ((Tuple.first pos) - (Tuple.first reg))<=diff) && (abs ((Tuple.second pos) - (Tuple.second reg))<=diff)

        nowPosition = monster.position

        newPos = (Tuple.first nowPos + Tuple.first direction,Tuple.second nowPos + Tuple.second direction)

        newPosition = {nowPosition|cx=Tuple.first newPos,cy=Tuple.second newPos}

        
        
    in 
        if checkfeasible newPos region difference  then {monster|position=newPosition,seed=seed1}  else monsterAct {monster|seed=seed1,direction = nowdir+90}

monsterShoot : List Monster -> Me  -> List Rectangle-> List Bullet -> List Bullet
monsterShoot newMonsterList me obstacles bulletList = 
    bulletList


