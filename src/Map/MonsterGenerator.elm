module Map.MonsterGenerator exposing (monsterGenerator)
import Shape exposing (Rectangle,recCollisionTest,recInit,recUpdate)
import Map.Map exposing (Monster,MonsterType,Obstacle)
import Random

-- import Map.Map exposing (Obstacle)
-- import Shape exposing (recInit)



monsterTypeNum : Int 
monsterTypeNum = 3

monsterTypeList : List MonsterType 
monsterTypeList = 
    let
        m1=MonsterType 100 100 "Yellow"
        m2=MonsterType 100 100 "Red"
        m3=MonsterType 100 100 "Blue"
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
        monsterPos=monster.position
        obstaclePosList = List.map (\value -> value.position) obstacles
        monsterPosList = List.map (\value->value.position) monsterList
        obstacleCol=List.filter (recCollisionTest monsterPos.edge) <| List.map (\value->value.edge) (obstaclePosList++monsterPosList)
    in
        List.isEmpty obstacleCol



monsterBuilding : List Monster -> Int -> List Obstacle -> Random.Seed -> (List Monster,Random.Seed)
monsterBuilding monsterList number obstacles seed0 =
    let
        (xTemp,seed1) = Random.step (Random.int 250 1750) seed0
        (yTemp,seed2) = Random.step (Random.int 250 1750) seed1
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

        monsterPos = Rectangle (toFloat xTemp) (toFloat yTemp) 25 25 recInit
        monsterNew = Monster (recUpdate monsterPos) monsterTypeTemp

    in 
        if number==0 then
            (monsterList,seed3)
        else
            if checkMonsterCollison monsterNew obstacles monsterList then
                monsterBuilding (monsterNew :: monsterList) (number-1) obstacles seed3
            else 
                monsterBuilding  monsterList number obstacles seed3