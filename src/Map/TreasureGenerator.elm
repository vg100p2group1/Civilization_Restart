module Map.TreasureGenerator exposing (treasureGenerator)
import Shape exposing (Rectangle,recCollisionTest,recInit,recUpdate,circleCollisonTest)
import Map.Map exposing (Monster,MonsterType,Obstacle)
import Random
import Weapon exposing(Bullet,ShooterType(..))
import Model exposing (Me)

monsterGenerator : Random.Seed -> List Obstacle -> (List Monster,Random.Seed)
monsterGenerator seed0 obstacle =
    let
        (number,seed1) = Random.step (Random.int 5 10) seed0
        -- obstacle = room.obstacles
        
        (monsterList,seed2) = monsterBuilding [] number obstacle seed1
    in
        (monsterList,seed2)


checkMonsterCollison : Monster -> List Obstacle -> List Monster -> Bool
checkMonsterCollison monster obstacles monsterList=
    let
        monsterRegion=monster.region
        obstaclePosList = List.map (\value -> value.position) obstacles
        monsterRegList = List.map (\value->value.region) monsterList
        obstacleCol=List.filter (recCollisionTest monsterRegion.edge) <| List.map (\value->value.edge) (obstaclePosList++monsterRegList)
    in
        List.isEmpty obstacleCol



monsterBuilding : List Monster -> Int -> List Obstacle -> Random.Seed -> (List Monster,Random.Seed)
monsterBuilding monsterList number obstacles seed0 =
    let
        (xTemp,seed1) = Random.step (Random.int 200 1500) seed0
        (yTemp,seed2) = Random.step (Random.int 200 1500) seed1
        (typeTemp, seed3) = Random.step (Random.int 0 monsterTypeNum) seed2
        (monsterSpeed, seed4) = Random.step (Random.float 2 6) seed3
        getMonsterType = 
            let
                headType =List.head <| List.drop typeTemp monsterTypeList 
            in 
                case headType of 
                    Just a ->
                        a
                    Nothing ->
                        MonsterType 0 0 ""
        monsterTypeTemp = getMonsterType

        monsterRegion = Rectangle (toFloat xTemp) (toFloat yTemp) 300 200 recInit
        monsterPos = Shape.Circle  (toFloat xTemp + 150) (toFloat yTemp + 100) 20 

        monsterNew = Map.Map.Monster monsterPos (recUpdate monsterRegion)  monsterTypeTemp 0 seed3 False 1 monsterSpeed

    in 
        if number==0 then
            (monsterList,seed3)
        else
            if checkMonsterCollison monsterNew obstacles monsterList then
                monsterBuilding (monsterNew :: monsterList) (number - 1) obstacles seed3
            else 
                monsterBuilding  monsterList number obstacles seed4
