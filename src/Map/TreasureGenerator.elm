module Map.TreasureGenerator exposing (treasureGenerator,updateTreasure,treasureLevelChange)
import Shape exposing (Rectangle,recCollisionTest,recInit,recUpdate,circleCollisonTest)
import Map.Map exposing (Treasure,TreasureType,Obstacle)
import Random
import Weapon exposing(Bullet,ShooterType(..))
import Model exposing (Me)
import Synthesis.Material exposing (Material)

treasureTypeNum : Int 
treasureTypeNum = 3

treasureTypeList : List TreasureType 
treasureTypeList = 
    let
        m1=TreasureType 1 100 "Yellow"
        m2=TreasureType 2 100 "Red"
        m3=TreasureType 3 100 "Blue"
    in 
        [m1,m2,m3,m3,m3,m2,m3,m3]


treasureGenerator : Random.Seed -> List Obstacle-> Int -> (List Treasure,Random.Seed)
treasureGenerator seed0 obstacle storey=
    let
        (numberTemp,seed1) = Random.step (Random.int 1 10) seed0
        -- obstacle = room.obstacles
        number = (numberTemp // 10) + 1
        (tresureList,seed2) = treasureBuilding [] number obstacle seed1 storey
    in
        (tresureList,seed2)


checkTreasureCollison : Treasure -> List Obstacle -> List Treasure -> Bool
checkTreasureCollison treasure obstacles treasureList=
    let
        treasurePos = treasure.position
        obstaclePosList = List.map (\value -> value.position) obstacles
        treasurePosList = List.map (\value->value.position) treasureList
        obstacleCol=List.filter (recCollisionTest treasurePos.edge) <| List.map (\value->value.edge) (obstaclePosList++treasurePosList)
    in
        List.isEmpty obstacleCol



treasureBuilding : List Treasure -> Int -> List Obstacle -> Random.Seed -> Int -> (List Treasure,Random.Seed)
treasureBuilding treasureList number obstacles seed0 storey=
    let
        (xTemp,seed1) = Random.step (Random.int 200 1500) seed0
        (yTemp,seed2) = Random.step (Random.int 200 1500) seed1
        (typeTemp, seed3) = Random.step (Random.int 0 (storey // 3)) seed2
        getTreasureType = 
            let
                headType =List.head <| List.drop typeTemp treasureTypeList 
            in 
                case headType of 
                    Just a ->
                        a
                    Nothing ->
                        TreasureType 0 0 ""
        treasureTypeTemp = getTreasureType

        treasurePos = Rectangle (toFloat xTemp) (toFloat yTemp) treasureTypeTemp.size treasureTypeTemp.size recInit  

        (treasureMaterial, seed4) = generateMaterial seed3 treasureTypeTemp storey

        treasureNew = Treasure  (recUpdate treasurePos)  treasureTypeTemp  seed4 False 0 treasureMaterial

    in 
        if number==0 then
            (treasureList,seed3)
        else
            if checkTreasureCollison treasureNew obstacles treasureList then
                treasureBuilding (treasureNew :: treasureList) (number - 1) obstacles seed3 storey
            else 
                treasureBuilding  treasureList number obstacles seed3 storey

updateTreasure : List Treasure -> List Int ->List Map.Map.Treasure
updateTreasure treasureList roomClearList=
    List.map (updateSingleTreasure roomClearList) treasureList

updateSingleTreasure :  List Int -> Treasure ->  Map.Map.Treasure
updateSingleTreasure roomClearList treasure=
    if List.member treasure.roomNum roomClearList then {treasure|canShow=True}else treasure


generateMaterial : Random.Seed-> TreasureType -> Int -> (Material,Random.Seed)
generateMaterial seed0 treasureType storey=
    let
        maxNum = treasureType.level * 3
        minNum = treasureType.level * 2

        -- d1 = Debug.log "seed" seed0 

        (s,seed1)=Random.step (Random.int minNum maxNum) seed0
        -- d2 = Debug.log "s" s

        (c,seed2)=Random.step (Random.int minNum maxNum) seed1
        (w,seed3)=Random.step (Random.int minNum maxNum) seed2
        (u,seed4)=Random.step (Random.int minNum maxNum) seed3 
    in
        (Material s c w u, seed4)

treasureLevelChange : Treasure -> Map.Map.Treasure
treasureLevelChange treasure = 
    let
        nowTreasureType = treasure.treasureType
        newTreasureType = {nowTreasureType | level = 4}
    in
        {treasure|treasureType = newTreasureType}