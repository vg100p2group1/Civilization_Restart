module Boss.Boses exposing (bossesGenerator)

import Shape exposing (Circle)
import Map.Map exposing (Boss,BossType,Obstacle)
import Model exposing (..)
import Config exposing (bulletSpeed)
import Weapon exposing (..)
import Random exposing (..)

bossTypeList : List BossType 4
bossTypeList = 
    let
        m1=BossType 150 150 "Yellow"
        m2=BossType 150 150 "Red"
        m3=BossType 150 150 "Blue"
    in 
        [m1,m2,m3]



bossGenerator : Random.Seed -> List Obstacle -> (List Boss,Random.Seed)
bossGenerator seed0 obstacle =
    let
        
        -- obstacle = room.obstacles
        
        (bossList,seed1) = bossBuilding [] number obstacle seed0
    in
        (bossList,seed1)


checkBossCollison : Boss -> List Obstacle -> List Boss -> Bool
checkBossCollison boss obstacles bossList=
    let
        bossRegion=boss.region
        obstaclePosList = List.map (\value -> value.position) obstacles
        bossRegList = List.map (\value->value.region) bossList
        obstacleCol=List.filter (recCollisionTest bossRegion.edge) <| List.map (\value->value.edge) (obstaclePosList++bossRegList)
    in
        List.isEmpty obstacleCol



bossBuilding : List Boss -> Int -> List Obstacle -> Random.Seed -> (List Boss,Random.Seed)
bossBuilding bossList number obstacles seed0 =
    let
        xTemp = 1000
        yTemp = 1000
        (typeTemp, seed3) = Random.step (Random.int 0 bossTypeNum) seed2
        (bossSpeed, seed4) = Random.step (Random.float 1 3 ) seed3
        getBossType = 
            let
                headType =List.head <| List.drop typeTemp bossTypeList 
            in 
                case headType of 
                    Just a ->
                        a
                    Nothing ->
                        BossType 0 0 ""
        bossTypeTemp = getBossType

        bossPos = Shape.Circle  (toFloat xTemp) (toFloat yTemp) 100 

        bossNew = Map.Map.Boss bossPos (recUpdate bossRegion)  bossTypeTemp 0 seed3 False 1 bossSpeed 0

    in 
        if number==0 then
            (bossList,seed3)
        else
            if checkBossCollison bossNew obstacles bossList then
                bossBuilding (bossNew :: bossList) (number - 1) obstacles seed3
            else 
                bossBuilding  bossList number obstacles seed4

updateBoss_ : Boss -> List Bullet -> Boss
updateBoss_ boss bullets =
    let
        hitBullets = bullets
                  |> List.filter (\b -> b.from == Player)
                  |> List.filter (\b -> circleCollisonTest b.hitbox boss.position)
        bossType_ = boss.bossType
        newBossType = {bossType_ | hp = bossType_.hp - List.sum (List.map (\b -> b.force) hitBullets)}
        {- debug test
        newBossType =
                if List.isEmpty hitBullets then
                    bossType_
                else
                    Debug.log "hitBoss" {bossType_ | hp = bossType_.hp - toFloat(20 * (List.length hitBullets)), color = "Green"}
        -}
    in
        {boss | bossType = newBossType}

updateBoss : List Boss -> List Bullet -> Me -> (List Boss,List Bullet)
updateBoss bosss bullets me =
    let
        finalBosss = bosss
                     |> List.filter (\m -> m.bossType.hp > 0)
                     |> List.map (\m -> updateBoss_ m bullets)
    in
        allBossAct finalBosss me bullets

updateRoomList : List Boss -> Int  -> List Int -> List Int 
updateRoomList bossList number nowRoomList= 
    
    if number <= 0 then nowRoomList 
        else if checkClearRoom number bossList then number :: (updateRoomList  bossList (number - 1)  nowRoomList )
            else updateRoomList bossList (number - 1) nowRoomList


checkClearRoom : Int -> List Boss -> Bool
checkClearRoom roomNumber bossList =
    let
        bossInRoom = List.filter (\b -> b.roomNum == roomNumber) bossList
        
    in
        (List.length bossInRoom) == 0