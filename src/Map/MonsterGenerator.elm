
module Map.MonsterGenerator exposing (monsterGenerator,updateMonster,updateRoomList)
import Shape exposing (Rectangle,recCollisionTest,recInit,recUpdate,circleCollisonTest)
import Map.Map exposing (Monster,MonsterType,Obstacle)
import Random
import Weapon exposing(Bullet,ShooterType(..))
import Model exposing (Me)
import Attributes exposing (getCurrentAttr,getMaxAttr,AttrType(..),defaultAttr)
import Monster.Monster exposing (allMonsterAct)
import Skill exposing (getSubSys, getSkill)
-- import Map.Map exposing (Obstacle)
-- import Shape exposing (recInit)



monsterTypeNum : Int 
monsterTypeNum = 3

monsterTypeList : List MonsterType 
monsterTypeList = 
    let
        m1=MonsterType 150 10 "Yellow"
        m2=MonsterType 150 10 "Red"
        m3=MonsterType 150 10 "Blue"
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
        (xTemp,seed1) = Random.step (Random.int 300 1500) seed0
        (yTemp,seed2) = Random.step (Random.int 300 1500) seed1
        (typeTemp, seed3) = Random.step (Random.int 0 monsterTypeNum) seed2
        (monsterSpeed, seed4) = Random.step (Random.float 1 3 ) seed3
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

        monsterNew = Map.Map.Monster monsterPos (recUpdate monsterRegion)  monsterTypeTemp 0 seed3 False 1 monsterSpeed 0

    in 
        if number==0 then
            (monsterList,seed3)
        else
            if checkMonsterCollison monsterNew obstacles monsterList then
                monsterBuilding (monsterNew :: monsterList) (number - 1) obstacles seed3
            else 
                monsterBuilding  monsterList number obstacles seed4

updateMonster_ : Monster -> List Bullet -> Me -> Monster
updateMonster_ monster bullets me =
    let
        hitBullets = bullets
                  |> List.filter (\b -> b.from == Player)
                  |> List.filter (\b -> circleCollisonTest b.hitbox monster.position)
        monsterType_ = monster.monsterType
        -- Skill Battle Fervor can influence the attack
        sub = getSubSys me.skillSys 2
        skill = getSkill sub (0,4)
        battleFervorFactor = 
            if skill.unlocked then
            let
                maxHealth = getMaxAttr Health me.attr
                currentHealth = getCurrentAttr Health me.attr
                loseHealthRate = 1 - toFloat currentHealth / toFloat maxHealth
            in
                1 + loseHealthRate / 2
            else
                1
        attackFactor = (getCurrentAttr Attack me.attr |> toFloat) / (getCurrentAttr Attack defaultAttr |> toFloat) * battleFervorFactor
        damage = attackFactor * List.sum (List.map (\b -> b.force) hitBullets)
        newMonsterType = {monsterType_ | hp = monsterType_.hp - damage}
        {- debug test
        newMonsterType =
                if List.isEmpty hitBullets then
                    monsterType_
                else
                    Debug.log "hitMonster" {monsterType_ | hp = monsterType_.hp - toFloat(20 * (List.length hitBullets)), color = "Green"}
        -}
    in
        {monster | monsterType = newMonsterType}

updateMonster : List Monster -> List Bullet -> Me -> (List Monster,List Bullet)
updateMonster monsters bullets me =
    let
        finalMonsters = monsters
                     |> List.filter (\m -> m.monsterType.hp > 0)
                     |> List.map (\m -> updateMonster_ m bullets me)
    in
        allMonsterAct finalMonsters me bullets

updateRoomList : List Monster -> Int  -> List Int -> List Int 
updateRoomList monsterList number nowRoomList= 
    
    if number <= 0 then nowRoomList 
        else if checkClearRoom number monsterList then number :: (updateRoomList  monsterList (number - 1)  nowRoomList )
            else updateRoomList monsterList (number - 1) nowRoomList


checkClearRoom : Int -> List Monster -> Bool
checkClearRoom roomNumber monsterList =
    let
        monsterInRoom = List.filter (\b -> b.roomNum == roomNumber) monsterList
        
    in
        (List.length monsterInRoom) == 0