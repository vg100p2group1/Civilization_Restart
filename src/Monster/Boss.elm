module Monster.Boss exposing (bossGenerator,updateBoss)

import Shape exposing (Rectangle,recCollisionTest,recInit,recUpdate,circleCollisonTest,circleRecTest,Circle )
import Map.Map exposing (Boss,BossType,Obstacle,Boss,BossType,ShootingType,AttackMode(..))
import Model exposing (..)
import Config exposing (bulletSpeed)
import Weapon exposing(Bullet,ShooterType(..))
import Random exposing (..)
import Time exposing (now,posixToMillis)
import Messages exposing (Msg(..))



bossTypeList : List BossType 
bossTypeList = 
    let
        m1=bossType1
        m2=bossType2
        m3=bossType3
        m4=bossType4
        m5=bossType5
        
    in 
        [m1,m2,m3,m4,m5]



bossGenerator : Random.Seed ->List Obstacle -> Int ->  List Boss
bossGenerator seed0 obstacle storey=
    let
        
        -- obstacle = room.obstacles
        
        bossList= bossBuilding [] obstacle ( storey // 2) seed0
    in
        bossList






bossBuilding : List Boss -> List Obstacle -> Int -> Random.Seed -> List Boss
bossBuilding bossList obstacles bossNum  seed0=
    let
        xTemp = 1000
        yTemp =  1000
        
        bossTypeTemp = 
            let
                headType =List.head <| List.drop bossNum bossTypeList 
            in 
                case headType of 
                    Just a ->
                        a
                    Nothing ->
                        BossType 500 0 0 0 "#Boss1" [] 
        bossPos =  Rectangle (toFloat xTemp) (toFloat yTemp) bossTypeTemp.width bossTypeTemp.height recInit

        bossNew = Map.Map.Boss (recUpdate bossPos) 0  bossTypeTemp  seed0 False 0 0

    in 
        
            
         [bossNew]

bossType1 : BossType
bossType1 = 
    let
        addDirection num =
            if num == 0 then [] else shootingType0 num :: addDirection (num - 1)


        stype1 = addDirection 36
    in
        BossType 300 1 200 200 "#Boss3" stype1 



bossType2 : BossType
bossType2 = 
    let
        addDirection num =
            if num == 0 then [] else shootingType1 num :: addDirection (num - 1)
        addDirection1 num =
            if num == 9 then [] else shootingType1 num :: addDirection (num - 1)


        stype3 = shootingType2 :: addDirection 9  ++ shootingType2 :: addDirection1 18
    in
        BossType 2000 1 200 200 "#Boss3" stype3  

bossType3 : BossType
bossType3 = 
    let
        stype2 = [shootingType3]
    in
        BossType 2000 1 200 200 "#Boss2" stype2  

bossType4 : BossType
bossType4 = 
    let
        addDirection num =
            if num == 0 then [] else shootingType0 num :: addDirection (num - 1)
        addDirection1 num =
            if num == 9 then [] else shootingType0 num :: addDirection (num - 1)


        stype3 = shootingType2 :: addDirection 9  ++ shootingType2 :: addDirection1 18
    in
        BossType 10000 1 200 200 "#Boss3" stype3

bossType5 : BossType
bossType5 = 
    let 
        addDirection num =
            if num == 0 then [] else shootingType3 :: addDirection (num - 1)
        stype4 = addDirection 5 ++ [shootingType4]
    in
        BossType 5000 1 200 200 "#Boss2" stype4    

shootingType0 : Float -> ShootingType
shootingType0 direction = 
    ShootingType Circled 30 direction 30 10 10 10

shootingType1 : Float -> ShootingType
shootingType1 direction = 
    ShootingType Circled 20 direction 30 10 10 10    

shootingType2 : ShootingType
shootingType2 = 
    ShootingType Targeted 10 20 30 5 5 10 

shootingType3 : ShootingType
shootingType3 = 
    ShootingType Targeted 15 60 30 20 5 7 

shootingType4 : ShootingType
shootingType4 = 
    ShootingType Bomb 2 0 100 0 50 7 



 
                

updateBoss_ : Boss -> List Bullet -> Boss
updateBoss_ boss bullets =
    let
        hitBullets = bullets
                  |> List.filter (\b -> b.from == Weapon.Player)
                  |> List.filter (\b -> circleRecTest  b.hitbox boss.position.edge)
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
updateBoss boss bullets me =
    let
        finalBoss = boss
                     |> List.filter (\m -> m.bossType.hp > 0)
                     |> List.map (\m -> updateBoss_ m bullets)
    in
         allBossAct finalBoss me bullets

allBossAct:  List Boss -> Me  -> List Bullet -> (List Boss,List Bullet)
allBossAct bossList me bulletList = 
    let 
        
        newBossList_ = List.map  (bossAct me) bossList

        (newBossList,newBulletList) = bossShoot newBossList_ me bulletList

    in
        (newBossList,newBulletList ++ bulletList)


bossAct :  Me -> Boss ->  Boss
bossAct  me boss = 
    let 
        
        
        distx = abs (me.x - boss.position.edge.cx)
        disty = abs (me.y - boss.position.edge.cy)

        

        checkActive = 
            (distx <= 1000) && (disty<=1000)

        firstShootingType = List.head boss.bossType.shootingType

        nowShootingType = 
            case firstShootingType of 
                    Just a ->
                        a
                    Nothing ->
                        shootingType1 0

                

        checkCanShoot =
            let 
                count = boss.timeBeforeAttack
            in  
                if boss.active then 
                    if count ==0 
                        then nowShootingType.bulletInterval  
                        else  count-1  
                else count


        
        
    in 
         {boss|active=checkActive,timeBeforeAttack=checkCanShoot} 

bossShoot : List Boss -> Me -> List Bullet -> (List Boss,List Bullet)
bossShoot bossList me bulletList = 
        let
            newList = List.map (newBullet me) bossList

            newTuple = List.unzip newList

            newBullets = List.concat (Tuple.second newTuple)

            newBoss = Tuple.first newTuple
        in
            (newBoss,newBullets)
 

        

newBullet : Me ->  Boss ->(Boss,List Bullet)
newBullet me boss = 
            let
                
                firstShootingType = List.head boss.bossType.shootingType

                nowShootingType = 
                    case firstShootingType of 
                        Just a ->
                            a
                        Nothing ->
                            shootingType1 0

                newSeed = initialSeed me.time

                newShootingType = List.drop 1 boss.bossType.shootingType ++ [nowShootingType]

                nowbossType = boss.bossType 

                newBossType = {nowbossType| shootingType=newShootingType}

                newBoss = {boss|bossType = newBossType}



                

            in
                if (boss.timeBeforeAttack==0) && (boss.active) then 
                    case nowShootingType.attackMode of
                        Circled ->
                            (newBoss, circledShoot boss nowShootingType.bulletNum nowShootingType [] )
                        Targeted ->
                            (newBoss,targetedShoot boss nowShootingType.bulletNum nowShootingType [] newSeed me)
                        Bomb ->
                            (newBoss,bombShoot boss nowShootingType.bulletNum nowShootingType [] newSeed me)
                    
                    
                    else(boss,[]) 

circledShoot : Boss -> Int -> ShootingType ->List Bullet -> List Bullet
circledShoot boss num shootingType bullitList =
    let
        angle = ((360 / toFloat  shootingType.bulletNum) + shootingType.direction)* (toFloat num)

        speedx= cos (degrees angle) * shootingType.speed
        speedy= sin (degrees angle)* shootingType.speed
        
        oneNewBullet : Bullet
        oneNewBullet = Bullet boss.position.edge.cx  boss.position.edge.cy shootingType.r (Circle boss.position.edge.cx boss.position.edge.cy 5) speedx speedy False Weapon.Monster shootingType.attack

    in
        if num==0 then bullitList
            else circledShoot boss (num - 1) shootingType (oneNewBullet :: bullitList )

targetedShoot : Boss -> Int -> ShootingType ->List Bullet -> Random.Seed -> Me ->List Bullet
targetedShoot boss num shootingType bullitList seed me=
    let
        

        distx =  me.x - boss.position.edge.cx
        disty =  me.y - boss.position.edge.cy

        dist = sqrt ((distx)^2 + (disty)^2)

        numtodirx  = 
            (cos (degrees directiondiff))
        numtodiry  = 
            (sin (degrees directiondiff))  

        

        (directiondiff,seed1) =  Random.step (Random.float -shootingType.direction shootingType.direction) seed 

        disriedSpeedx= 
             (distx / dist)
        disriedSpeedy= 
            (disty / dist)

        speedx = disriedSpeedx * numtodirx - numtodiry * disriedSpeedy

        speedy = disriedSpeedx * numtodiry + numtodirx * disriedSpeedy
        
        oneNewBullet : Bullet
        oneNewBullet = Bullet boss.position.edge.cx  boss.position.edge.cy shootingType.r (Circle boss.position.edge.cx boss.position.edge.cy 5) (10*(speedx )) (10*(speedy )) False Weapon.Monster shootingType.attack

    in
        if num==0 then bullitList
            else targetedShoot boss (num - 1) shootingType (oneNewBullet :: bullitList ) seed1 me

bombShoot : Boss -> Int -> ShootingType ->List Bullet -> Random.Seed -> Me ->List Bullet
bombShoot boss num shootingType bullitList seed me=
    let
        

        
        

        (xran,seed1) =  Random.step (Random.float -500 500) seed 
        (yran,seed2) =  Random.step (Random.float -500 500) seed1 

        xtemp =  boss.position.edge.cx +xran
        ytemp= boss.position.edge.cy +yran

        
        
        oneNewBullet : Bullet
        oneNewBullet = Bullet xtemp ytemp shootingType.r (Circle xtemp ytemp shootingType.r ) 0 0 False Weapon.Monster shootingType.attack

    in
        if num==0 then bullitList
            else targetedShoot boss (num - 1) shootingType (oneNewBullet :: bullitList ) seed1 me