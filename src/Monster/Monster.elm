module Monster.Monster exposing (allMonsterAct)

import Shape exposing (Circle)
import Map.Map exposing (Monster,MonsterType,Obstacle)
import Model exposing (..)
import Config exposing (bulletSpeed)
import Weapon exposing (..)
import Random exposing (..)


allMonsterAct:  List Monster -> Me  -> List Bullet -> (List Monster,List Bullet)
allMonsterAct monsterList me bulletList = 
    let 

        newMonsterList = List.map  (monsterAct me) monsterList

        newBulletList = monsterShoot newMonsterList me bulletList

    in
        (newMonsterList,newBulletList)

monsterAct :  Me -> Monster ->  Monster
monsterAct  me monster = 
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
        

        checkActive = 
            ((abs (monster.position.cx)) + (abs (monster.position.cy)))<=1000
                

        checkCanShoot =
            let count = monster.timeBeforeAttack
            in  if monster.active then if count ==0 then 10 else  count-1  else count

        
        
    in 
        if checkfeasible newPos region difference  then {monster|position=newPosition,seed=seed1,active=checkActive,timeBeforeAttack=checkCanShoot}  else monsterAct me {monster|seed=seed1,direction = nowdir+90}

monsterShoot : List Monster -> Me -> List Bullet -> List Bullet
monsterShoot monsterList me bulletList = 
    let
        
         

        activemonster =  
             List.filter (\m -> m.timeBeforeAttack==0) 
                (List.filter (\m -> m.active) monsterList)
        newBullets= List.map newBullet activemonster

        distx monster =  -monster.position.cx
        disty monster = -monster.position.cy

        dist monster = sqrt ((distx monster)^2 + (disty monster)^2)

        speedx monster= 
            (distx monster) / (dist monster)
        speedy monster= 
            (disty monster) / (dist monster)

        newBullet : Monster -> Bullet

        newBullet monster  =
             Bullet monster.position.cx monster.position.cy 5 (Circle monster.position.cx monster.position.cy 5) (bulletSpeed*(speedx monster)) (10*(speedy monster)) False Weapon.Monster monster.monsterType.attack
    in 

    List.append  bulletList newBullets


