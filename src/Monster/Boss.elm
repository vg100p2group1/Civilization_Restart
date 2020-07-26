module Monster.Boss exposing (bossGenerator)

import Shape exposing (Rectangle,recCollisionTest,recInit,recUpdate,circleCollisonTest)
import Map.Map exposing (Boss,BossType,Obstacle,Boss,BossType,ShootingType,AttackMode(..))
import Model exposing (..)
import Config exposing (bulletSpeed)
import Weapon exposing (..)
import Random exposing (..)



bossTypeList : List BossType 
bossTypeList = 
    let
        m1=bossType1
        
    in 
        [m1,m1,m1]



bossGenerator : Random.Seed ->List Obstacle ->  List Boss
bossGenerator seed0 obstacle =
    let
        
        -- obstacle = room.obstacles
        
        bossList= bossBuilding [] obstacle 0 seed0
    in
        bossList






bossBuilding : List Boss -> List Obstacle -> Int -> Random.Seed -> List Boss
bossBuilding bossList obstacles bossNum  seed0=
    let
        xTemp = 1000
        yTemp = 1000
        
        bossTypeTemp = 
            let
                headType =List.head <| List.drop bossNum bossTypeList 
            in 
                case headType of 
                    Just a ->
                        a
                    Nothing ->
                        BossType 0 0 0 "black" []
        bossPos = Rectangle (toFloat xTemp) (toFloat yTemp) bossTypeTemp.width bossTypeTemp.height recInit

        bossNew = Map.Map.Boss (recUpdate bossPos) 1  bossTypeTemp  seed0 False 0 0

    in 
        
            
        [bossNew]

bossType1 : BossType
bossType1 = 
    let
        stype1 = [shootingType1]
    in
        BossType 1 200 200 "red" stype1

shootingType1 : ShootingType
shootingType1 = 
    ShootingType Circled 10 0 30 10 5 10    

shootingType2 : ShootingType
shootingType2 = 
    ShootingType Targeted 10 20 30 10 5 10    

 
                

-- updateBoss_ : Boss -> List Bullet -> Boss
-- updateBoss_ boss bullets =
--     let
--         hitBullets = bullets
--                   |> List.filter (\b -> b.from == Player)
--                   |> List.filter (\b -> circleCollisonTest b.hitbox boss.position)
--         bossType_ = boss.bossType
--         newBossType = {bossType_ | hp = bossType_.hp - List.sum (List.map (\b -> b.force) hitBullets)}
--         {- debug test
--         newBossType =
--                 if List.isEmpty hitBullets then
--                     bossType_
--                 else
--                     Debug.log "hitBoss" {bossType_ | hp = bossType_.hp - toFloat(20 * (List.length hitBullets)), color = "Green"}
--         -}
--     in
--         {boss | bossType = newBossType}

-- updateBoss : List Boss -> List Bullet -> Me -> (List Boss,List Bullet)
-- updateBoss bosss bullets me =
--     let
--         finalBosss = bosss
--                      |> List.filter (\m -> m.bossType.hp > 0)
--                      |> List.map (\m -> updateBoss_ m bullets)
--     in
--         allBossAct finalBosss me bullets

