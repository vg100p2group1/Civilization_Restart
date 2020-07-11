module Map.MonsterGenerator exposing (monsterGenerator)
import Shape exposing (Rectangle,recCollisionTest,recInit,recUpdate)
import Map.Map exposing (Monster,MonsterType,Obstacle)
import Random
import Shape exposing (circleInit)

-- import Map.Map exposing (Obstacle)
-- import Shape exposing (recInit)



monsterTypeNum : Int 
monsterTypeNum = 3

monsterTypeList : List MonsterType 
monsterTypeList = 
    let
        m1=MonsterType 150 150 "Yellow"
        m2=MonsterType 150 150 "Red"
        m3=MonsterType 150 150 "Blue"
    in 
        [m1,m2,m3]



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

        monsterRegion = Rectangle (toFloat xTemp) (toFloat yTemp) 200 200 recInit
        monsterPos = Shape.Circle  (toFloat xTemp + 100) (toFloat yTemp + 100) 50 

        monsterNew = Monster monsterPos (recUpdate monsterRegion)  monsterTypeTemp

    in 
        if number==0 then
            (monsterList,seed3)
        else
            if checkMonsterCollison monsterNew obstacles monsterList then
                monsterBuilding (monsterNew :: monsterList) (number - 1) obstacles seed3
            else 
                monsterBuilding  monsterList number obstacles seed3