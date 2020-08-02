module Update exposing (update)
import Messages exposing (Msg(..),ShiftMsg(..),PageMsg(..),WeaponChoosingMsg(..))
import Model exposing (Model,Me,State(..),Direction(..),Dialogues, Sentence, AnimationState,defaultMe,mapToViewBox,GameState(..),sentenceInit,Side(..),Page(..))
import Shape exposing (Rec,Rectangle,Circle,CollideDirection(..),recCollisionTest,recUpdate,recInit, recCollisionTest,circleRecTest,circleCollisonTest)
import Map.Map exposing (Map,mapConfig,Treasure,treasureInit,Door)
import Config exposing (playerSpeed,viewBoxMax,bulletSpeed)
import Weapon exposing (Bullet,bulletConfig,ShooterType(..),defaultWeapon,Weapon,generateBullet,Arsenal(..))
import Debug
import UpdateSkill exposing (updateSkill)
-- import Svg.Attributes exposing (viewBox)
-- import Html.Attributes exposing (value)
import Map.MapGenerator exposing (roomGenerator,roomInit)
import Monster.Boss exposing (updateBoss)
import Map.MapDisplay exposing (showMap, mapWithGate,mapInit)
import Map.MonsterGenerator exposing (updateMonster,updateRoomList)
import Map.TreasureGenerator exposing (updateTreasure)
import Map.Gate exposing (updateGate)
import Animation.PlayerMoving exposing (playerMove)
import Control.ExplosionControl exposing (updateExplosion,explosionToViewbox)
import Synthesis.UpdateSynthesis exposing (updateSynthesis)
import Synthesis.Package exposing (packageUpdate)
import Control.EnableDoor exposing (enableDoor)
import Attributes exposing (setCurrentAttr,getCurrentAttr, getMaxAttr, AttrType(..),defaultAttr)
import Init exposing (init)
import Skill exposing (subSysBerserker,skillDualWield,skillAbsoluteTerritoryField,skillInvisible,subSysPhantom,subSysMechanic,skillFlash,skillState,skillDirectionalBlasting)
import Time exposing (..)
import Random exposing (..)
import Bomb exposing (makeBomb, bombTick)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Start ->
            (init, Cmd.none)
        Pause ->
            ( {model|gameState=Paused}, Cmd.none)
        Resume ->
            ( {model|gameState=Playing}, Cmd.none)
        ChangeGameState ->
            let
                newModel =
                    case model.gameState of
                        Playing -> {model|gameState=Paused}
                        Paused -> {model|gameState=Playing}
                        Stopped -> {model|gameState=Playing}
            in
                (newModel, Cmd.none)
        MoveLeft on ->
            let 
                pTemp = model.myself 
                me= {pTemp | moveLeft = on, moveRight =  False, preDirection=DirectionLeft}
            in
                ( {model| myself= me}
                , Cmd.none
                )

        MoveRight on ->
            let 
                pTemp =  model.myself
                me= {pTemp | moveRight = on, moveLeft = False, preDirection=DirectionRight}
            in
                ( {model| myself= me}
                , Cmd.none
                )

        MoveUp on ->
            let
                pTemp =  model.myself 
                me= {pTemp | moveUp = on, moveDown =  False}
            in
                ( {model| myself= me}
                , Cmd.none
                )

        MoveDown on ->
            let 
                pTemp =  model.myself
                me= {pTemp | moveDown = on, moveUp = False}
            in
                ( {model| myself= me}
                , Cmd.none
                )
        
        -- Map ->
        --  ({model | map = not model.map},Cmd.none)
        
        MouseMove newMouseData ->
            let 
                pTemp = model.myself 
                -- d2 = Debug.log "mePos" (pTemp.x,pTemp.y)
                -- d = Debug.log "mouse" newMouseData 
                me = {pTemp | mouseData = mouseDataUpdate model newMouseData}
                getDirection = 
                    if (Tuple.first me.mouseData)>=500 then
                        DirectionRight
                    else 
                        DirectionLeft
            in 
                ({model|myself = {me|weaponDirection=getDirection}},Cmd.none)
        
        MouseDown ->
            let
                pTemp = model.myself
                me = {pTemp | fire = True}
                {-
                newShoot = fireBullet model.myself.currentWeapon me.mouseData (me.x,me.y)
                newBullet = newShoot ++ model.bullet
                -}
                -- newBulletViewbox = List.map (\value -> {value| x=500,y=500}) newBullet
            in
                ({model|myself = me},Cmd.none)
        
        MouseUp ->
            let
                pTemp =  model.myself
                weapon=pTemp.currentWeapon
                me= {pTemp|fire=False,currentWeapon={weapon|hasFired=False}}
            in
                ({model|myself = me},Cmd.none) 
        FMsg ->  -- FMsg
            if model.gameState == Playing then
                if model.state == NextStage then
                    let
                        roomNew =
                            roomGenerator (model.storey+1) (initialSeed model.myself.time) 

                        -- d1=Debug.log "room" (List.map (\value -> value.position) <| Tuple.first roomNew)

                        (roomNew2,mapNew) = mapWithGate (Tuple.first roomNew) (List.length (Tuple.first roomNew)) mapConfig (initialSeed model.myself.time)
                        meTemp = model.myself
                        weaponUnlockSys = meTemp.weaponUnlockSys
                        newSys = if model.storey >= 1 && model.storey <= 4 then
                                    {weaponUnlockSys|active=True}
                                 else
                                    weaponUnlockSys
                        meNew = {defaultMe|weapons=meTemp.weapons,currentWeapon=meTemp.currentWeapon,package=meTemp.package,skillSys=meTemp.skillSys, attr = meTemp.attr,weaponUnlockSys=newSys}
                        -- it should be updated when dialogues are saved in every room
                        newDialogues = updateDialogues model
                    in
                        ({model|myself=meNew,rooms=(roomNew2,Tuple.second roomNew),map=mapNew,viewbox=mapNew,state=Dialogue,currentDialogues=newDialogues,gameState=Paused,storey=model.storey+1},Cmd.none)
                else 
                    case model.state of
                        PickTreasure t ->
                            let
                                meTemp = model.myself
                                package = meTemp.package
                                newPackage = packageUpdate package t
                                nowSkill = meTemp.skillSys

                                nowPoints = nowSkill.points

                                newSkill =  if t.treasureType.level == 4 then {nowSkill| points = nowPoints + 4} else nowSkill

                                newTreasureList = List.filter (\value->value/=t) model.map.treasure
                                mapTemp = model.map
                                mapNew = {mapTemp|treasure=newTreasureList}
                            in
                                ({model|myself={meTemp|package=newPackage,skillSys = newSkill},map=mapNew},Cmd.none)
                        _ ->
                            (model, Cmd.none)
            else
                (model, Cmd.none)
        Tick time ->
            -- let
            --     d1=Debug.log "d1" model.pageState
            -- in
                if model.pageState == GamePage then  
                    if model.paused then
                        (model, Cmd.none)
                    else
                        (animate model, Cmd.none)
                else 
                    ({model|wholeCounter=model.wholeCounter+1}, Cmd.none)

        NextSentence ->
            (updateSentence 0 model, Cmd.none)

        -- the dialogue should be displayed when the player enters a new room actually
        ShowDialogue ->
            ({ model | state = Dialogue, gameState = Paused}, Cmd.none)

        ChangeWeapon_ number ->
            if model.gameState == Playing then
                (changeWeapon (number - 1) model, Cmd.none)
            else
                (model, Cmd.none)

        ChangeWeapon shiftMsg->
            if model.gameState == Playing then
                case shiftMsg of
                    Next ->
                        (changeWeapon (modBy (List.length model.myself.weapons) model.myself.currentWeapon.number) model, Cmd.none)
                    Previous ->
                        (changeWeapon (modBy (List.length model.myself.weapons) (model.myself.currentWeapon.number - 2)) model, Cmd.none)
            else
                (model, Cmd.none)

        Resize width height ->
            ( { model | size = ( toFloat width, toFloat height ) }
            , Cmd.none
            )

        GetViewport { viewport } ->
            ( { model
                | size =
                    ( viewport.width
                    , viewport.height
                    )
              }
            , Cmd.none
            )
        
        SkillChange skillMsg ->
            updateSkill skillMsg model
        
        SynthesisSystem systhesisMsg ->
            updateSynthesis systhesisMsg model

        DualWield ->
            (updateDualWield model, Cmd.none)

        Flash ->
            (updateFlashStatus model, Cmd.none)

        ATField ->
            (updateATField model, Cmd.none)

        Invisibility ->
            (updateInvisibility model, Cmd.none)
        
        PlaceBomb ->
            (placeBomb model, Cmd.none)
<<<<<<< HEAD

        WeaponChoosing weaponChoosingMsg ->
            (updateWeaponChoosing weaponChoosingMsg model, Cmd.none)

        UnlockTrigger ->
            let
                me = model.myself
                sys = me.weaponUnlockSys
                newModel = {model|myself={me|weaponUnlockSys={sys|active=True}},gameState=Paused}
            in
                (newModel, Cmd.none)
=======
>>>>>>> Wu_Qifei

        Noop ->
            let 
                pTemp =  model.myself
                me= {pTemp | moveDown = False, moveUp = False, moveRight =False, moveLeft=False}
            in
                ( {model| myself= me}
                , Cmd.none
                )
        Tictoc newTime ->

            let 
                me = model.myself
                newMe = {me |time = posixToMillis  newTime}

            in 

                ( { model | myself=newMe }
                    , Cmd.none
                )
        PageChange pageMsg ->  
            case pageMsg of 
                Welcome ->
                    ({model|pageState=WelcomePage},Cmd.none)
                Help ->
                    ({model|pageState=HelpPage},Cmd.none)
                Game ->
                    ({model|pageState=GamePage},Cmd.none)
                About ->
                    ({model|pageState=AboutPage},Cmd.none)
                Story ->
                    ({model|pageState=StoryPage},Cmd.none)


changeWeapon : Int -> Model -> Model
changeWeapon number model =
    let
        pTemp = model.myself
    in
    if pTemp.currentWeapon.shiftCounter == 0 then
        let
            weapon = List.head (List.drop number model.myself.weapons)
            newWeapon =
                case weapon of
                    Just a ->
                        a
                    Nothing ->
                        defaultWeapon
            me = { pTemp | currentWeapon = {newWeapon|shiftCounter=15}}
        in
            {model | myself = me}
    else
        model

mouseDataUpdate : Model -> (Float,Float) -> (Float,Float)  
mouseDataUpdate model mousedata = 
    let
        ( w, h ) =
            model.size
        
        configheight =1000
        configwidth = 1000
        r =
            if w / h > 1 then
                Basics.min 1 (h / configwidth)

            else
                Basics.min 1 (w / configheight)
        -- d1=Debug.log "r" r 

        xLeft = (w - configwidth*r) / 2 
        yTop = (h - configheight*r) / 2

        (mx,my) = 
            mousedata 

    in
        ((mx - xLeft)/r, (my - yTop)/r)



fireBullet_ : Weapon -> (Float, Float) -> (Float, Float) -> Bool -> Me-> (List Bullet, Weapon)
fireBullet_ weapon (mouseX,mouseY) (meX, meY) dual me=
    let
        bullet = fireBullet weapon (mouseX,mouseY) (meX, meY) dual me
        (newShoot, fireFlag, counter) =
            if weapon.counter <= 0 then
                if weapon.auto then
                    (bullet, False, weapon.period)
                else if weapon.hasFired then
                    ([], True, 0)
                else
                    (bullet, True, weapon.period)
            else
                ([], weapon.hasFired, weapon.counter)
    in
        (newShoot, {weapon|hasFired=fireFlag,counter=counter})

animate :  Model -> Model
animate  model =
    -- (model,Cmd.none)
    let
        -- d1=Debug.log "Model" model.myself
        me = model.myself
        attr = me.attr
        gate = model.map.gate
        isDead = 0 == getCurrentAttr Health attr
        (newShoot, weapon) = if model.myself.fire then
                                 if getCurrentAttr Clip attr > 0 then
                                    fireBullet_ model.myself.currentWeapon me.mouseData (me.x,me.y) (model.myself.dualWield > 0) me
                                 else
                                    ([], model.myself.currentWeapon)
                             else
                                ([], model.myself.currentWeapon)
        newAttr = setCurrentAttr Clip (-(List.length newShoot) * weapon.cost) attr
        weaponCounter =
            if weapon.counter <= 0 then
                0
            else
                weapon.counter - 1
        shiftCounter =
            if weapon.shiftCounter <= 0 then
                0
            else
                weapon.shiftCounter - 1
        newWeapons = List.map (\w -> {w | period = (getCurrentAttr ShootSpeed defaultAttr |> toFloat) / (getCurrentAttr ShootSpeed newAttr |> toFloat) * w.maxPeriod}) newMe.weapons
        newPeriod = (getCurrentAttr ShootSpeed defaultAttr |> toFloat) / (getCurrentAttr ShootSpeed newAttr |> toFloat) * newMe.currentWeapon.maxPeriod
        newBullet_ =  newShoot ++ model.bullet
        (newBomb,explodeBomb) = bombTick model.bomb
        (newMonsters,newBullet__) = updateMonster model.map.monsters newBullet_ explodeBomb me
        newClearList = updateRoomList model.map.monsters model.map.roomCount [] model.map.boss
        newTreasure = updateTreasure model.map.treasure newClearList
        newGate = updateGate model.map.gate newClearList
        (newBoss,newBullet) = updateBoss model.map.boss newBullet__ me
        map = model.map
        

        (newDoors,collideDoor) = enableDoor me (Tuple.first model.rooms) map.doors newClearList

        (newMe,collision) = speedCase me model.map collideDoor

        newMap = {map | monsters = newMonsters,treasure=newTreasure,doors=newDoors,boss=newBoss,gate={newGate|counter=gate.counter+1}}
        newViewbox = mapToViewBox newMe newMap
        (newBulletList, filteredBulletList, (hitPlayer, atFieldBullet)) = updateBullet newMe model.map newBullet collision
        newBulletListViewbox = bulletToViewBox newMe newBulletList
        newExplosion = updateExplosion model.explosion filteredBulletList explodeBomb
        newExplosionViewbox = explosionToViewbox newMe newExplosion
        newState = updateState model
        meHit = hit hitPlayer atFieldBullet {newMe|attr=newAttr}
        meCooling = coolSkills meHit

        --debug
        number = Debug.log "number of weapons" (List.length meHit.weapons)
        number2 = Debug.log "unlocked weapons" (List.length meHit.weaponUnlockSys.unlockedWeapons)
    in
        {model| myself = {meCooling|weapons=newWeapons,counter=newMe.counter+1,url=playerMove newMe,currentWeapon={weapon|counter=weaponCounter,period=newPeriod,shiftCounter=shiftCounter}},
                viewbox=newViewbox, map = newMap, bullet= newBulletList,bulletViewbox=newBulletListViewbox,state = newState,
                explosion=newExplosion,explosionViewbox=newExplosionViewbox, isGameOver=isDead, bomb = newBomb}



speedCase : Me -> Map-> List Door -> (Me,(Bool,Bool))
speedCase me map collideDoor= 
    let 
        speedFactor = (getCurrentAttr Speed me.attr |> toFloat) / (getCurrentAttr Speed defaultAttr |> toFloat)
        speed = speedFactor * playerSpeed
        getNewXSpeed =
            if me.moveLeft then 
                (True,-speed)
            else
                if me.moveRight then
                  (True,speed)
                else
                    (False,0)
        
        (horizontal,newXspeed)=getNewXSpeed
        
        getNewYSpeed =  
            if me.moveUp then 
                (True,-speed)
            else
                if me.moveDown then
                  (True,speed)
                else
                    (False,0)

        (vertical,newYspeed)=getNewYSpeed

        getSpeed = 
            case (horizontal,vertical) of
                (True,True) ->
                    (newXspeed/1.414,newYspeed/1.414)
                _ ->
                    (newXspeed,newYspeed)
        (xSpeedFinalTemp,ySpeedFinalTemp) = getSpeed
        
        (newXTemp,newYTemp) = (me.x+xSpeedFinalTemp,me.y+ySpeedFinalTemp) --Todo
        -- -- recTemp = Rec newX newY (viewBoxMax/2) (viewBoxMax/2)

        collideType = wallCollisionTest (Circle newXTemp newYTemp 20) (map.obstacles++(List.map (\value->value.position) map.walls)++map.roads
             ++(List.map (\t->t.position) collideDoor)
            ) 
        -- d = Debug.log "Type" collideType
        -- d = Debug.log "x"
        getCollideType collideList  = 
            case List.head collideList of 
                Just a ->
                    a
                _ ->
                    NoCollide 0
        (typeA,typeB) = (getCollideType collideType, getCollideType<|List.drop 1 collideType)

        getXY = -- TO DO Road 2墙重合有 bug
            case (typeA,typeB) of
                (FromRight a,NoCollide b) ->
                    ((newXTemp-a,newYTemp),(ySpeedFinalTemp-a,ySpeedFinalTemp),(True,False))
                (FromLeft a,NoCollide b) ->
                    ((newXTemp-a,newYTemp),(ySpeedFinalTemp-a,ySpeedFinalTemp),(True,False))
                (FromUp a,NoCollide b) ->
                    ((newXTemp,newYTemp-a),(xSpeedFinalTemp,ySpeedFinalTemp-a),(False,True))
                (FromDown a,NoCollide b) ->
                    ((newXTemp,newYTemp-a),(xSpeedFinalTemp,ySpeedFinalTemp-a),(False,True))
                
                (FromLeft a, FromUp b) ->
                    ((newXTemp-a,newYTemp-b),(xSpeedFinalTemp-a,ySpeedFinalTemp-b),(True,True))
                (FromLeft a, FromDown b) ->
                    ((newXTemp-a,newYTemp-b),(xSpeedFinalTemp-a,ySpeedFinalTemp-b),(True,True))
                (FromRight a, FromUp b) ->
                    ((newXTemp-a,newYTemp-b),(xSpeedFinalTemp-a,ySpeedFinalTemp-b),(True,True))
                (FromRight a, FromDown b) ->
                    ((newXTemp-a,newYTemp-b),(xSpeedFinalTemp-a,ySpeedFinalTemp-b),(True,True))
                
                (FromUp b, FromLeft a) ->
                    ((newXTemp-a,newYTemp-b),(xSpeedFinalTemp-a,ySpeedFinalTemp-b),(True,True))
                (FromUp b, FromRight a) ->
                    ((newXTemp-a,newYTemp-b),(xSpeedFinalTemp-a,ySpeedFinalTemp-b),(True,True))
                (FromDown b, FromLeft a) ->
                    ((newXTemp-a,newYTemp-b),(xSpeedFinalTemp-a,ySpeedFinalTemp-b),(True,True))
                (FromDown b, FromRight a) ->
                    ((newXTemp-a,newYTemp-b),(xSpeedFinalTemp-a,ySpeedFinalTemp-b),(True,True))

                (NoCollide a,NoCollide b) ->
                    ((newXTemp,newYTemp),(xSpeedFinalTemp,ySpeedFinalTemp),(False,False))
                _ ->
                    ((me.x,me.y),(0,0),(False,False))
        
        ((newX,newY),(xSpeedFinal,ySpeedFinal),(collisionX,collisionY)) = getXY
        
    in
        ({me|xSpeed=xSpeedFinal,ySpeed=ySpeedFinal,x=newX,y=newY,hitBox=(Circle newX newY 20)},(collisionX,collisionY))

wallCollisionTest : Circle -> List Rectangle -> List CollideDirection
wallCollisionTest hitbox wallList =
    let
        collide model =
            (Shape.circleRecDirection hitbox model) /= Shape.NoCollide 0
        wallColList=List.filter collide <| List.map (\value->value.edge) wallList
        wallColType = List.map (\value-> Shape.circleRecDirection hitbox value )wallColList
        -- d1=Debug.log "hitbox" hitbox
        -- d2=Debug.log "Col List" wallColList
    in
        -- List.isEmpty wallColList
        listUniq (List.length wallColType) wallColType [] 

listUniq : Int -> List CollideDirection -> List CollideDirection -> List CollideDirection
listUniq num orignial now=
    let
        getHead = 
            case List.head orignial of 
                Just a ->
                    a
                _ ->
                    NoCollide 0
        newOriginal = List.drop 1 orignial
        newNow = 
            if List.member getHead now then
                now
            else 
                now ++ [getHead]

    in 
        if num==0 then
            now
        else
            listUniq (num - 1) newOriginal newNow


activateUpdate : Float -> Float -> { a | active : Bool, elapsed : Float } -> { a | active : Bool, elapsed : Float }
activateUpdate interval elapsed state =
    let
        elapsed_ = state.elapsed + elapsed
    in
        if elapsed_ > interval then
            {state | active = True, elapsed = elapsed_ - interval}
        else
            {state | elapsed = elapsed_}

{-
startUpdateSen : Model -> Model
startUpdateSen model =
    if model.changeSentence then
        { model | sentenceState = Just {active = True, elapsed = 0}}
    else
        { model | sentenceState = Nothing}
-}

updateSentence : Float -> Model -> Model
updateSentence elapsed model =
    case model.state of
        Dialogue ->
            let
                head = List.head model.currentDialogues
                end =
                    case head of
                        Just a ->
                            False
                        Nothing ->
                            True
                (state, newDialogues, gameState) =
                    if end then
                        (Others, model.currentDialogues, Playing)
                    else
                        (Dialogue, List.drop 1 model.currentDialogues, Paused)
            in
                {model | state = state, currentDialogues = newDialogues, gameState = gameState}
        _ ->
            model

fireBullet : Weapon -> (Float, Float) -> (Float, Float) -> Bool -> Me-> List Bullet
fireBullet weapon (mouseX,mouseY) (meX, meY) dual  me=
    let
        posX = mouseX
        posY = mouseY

        -- d1=Debug.log "mouse" (posX,posY)
        -- d2=Debug.log "me" (meX,meY)
        unitV = sqrt ((posX - 500) * (posX - 500) + (posY - 500) * (posY - 500))
        -- velocity decomposition

        xTemp = bulletSpeed / unitV * (posX - 500)
        yTemp = bulletSpeed / unitV * (posY - 500)
        bullet = generateBullet weapon
        newCircle = Circle meX (meY+10) bullet.r
        newBullet = {bullet | x=meX,y=(meY+10),hitbox = newCircle, speedX=xTemp+me.xSpeed, speedY=yTemp+me.ySpeed}
        bulletList_ =
            case weapon.extraInfo of
                Shotgun ->
                    -- the shotgun will shoot three bullets at one time and has an angle of 30 degrees
                    let
                        bullet1 = {newBullet|speedX=(sqrt 3)/2*xTemp+0.5*yTemp,speedY=(sqrt 3)/2*yTemp-0.5*xTemp}
                        bullet2 = {newBullet|speedX=(sqrt 3)/2*xTemp-0.5*yTemp,speedY=(sqrt 3)/2*yTemp+0.5*xTemp}
                    in
                    [newBullet, bullet1, bullet2]
                _ ->
                    [newBullet]
        bulletList =
            if dual then
                let
                    b1 = bulletList_ |> List.map (\b -> {b|y=b.y-20/unitV*(posX - 500),x=b.x+20/unitV*(posY - 510),hitbox=Circle (b.x+20/unitV*(posY - 500)) (b.y-20/unitV*(posX - 510)) b.r})
                    b2 = bulletList_ |> List.map (\b -> {b|y=b.y+20/unitV*(posX - 500),x=b.x-20/unitV*(posY - 510),hitbox=Circle (b.x-20/unitV*(posY - 500)) (b.y+20/unitV*(posX-510)) b.r})
                in
                    List.append b1 b2
            else
                bulletList_
    in
        bulletList



updateBullet : Me-> Map -> List Bullet -> (Bool,Bool) -> (List Bullet, List Bullet, (List Bullet, List Bullet))
updateBullet me map bullets (collisionX,collisionY) =
    let
        updateXY b =
            let
                -- d2=Debug.log "meX" me.xSpeed
                newX = 
                    
                        b.hitbox.cx + b.speedX
                newY = 
                        b.hitbox.cy + b.speedY
                newHitbox = Circle newX newY b.hitbox.r
            in
                {b|hitbox = newHitbox,x=newX, y=newY}

        allBullets = bullets
                    -- hit wall
                    |> List.filter (\b -> not (List.any (circleRecTest b.hitbox) (List.map .edge (List.map (\value->value.position) map.walls))))
                    -- hit obstacles
                    |> List.filter (\b -> not (List.any (circleRecTest b.hitbox) (List.map .edge map.obstacles)))
                    -- hit doors

                    |> List.filter (\b -> not (List.any (circleRecTest b.hitbox) (List.map .edge (List.map (\value->value.position) map.doors))))
                    -- on the roads
                    |> List.filter (\b -> not (List.any (circleRecTest b.hitbox) (List.map .edge map.roads)))
                    -- hit monsters and are shoot by player
                    |> List.filter (\b -> not (List.any (circleCollisonTest b.hitbox) (List.map .position map.monsters))||(b.from == Monster))
                    -- hit bosses and are shoot by player
                    |> List.filter (\b -> not (List.any (circleRecTest b.hitbox) ((List.map .edge (List.map (\value->value.position) map.boss))))||(b.from == Monster))

        (flyingBullets, hitPlayer) = List.partition (\b -> (b.from == Player) || not (circleCollisonTest b.hitbox me.hitBox)) allBullets
        
        -- AT Field can stop bullets
        fieldOn = me.absoluteTerrifyField > 0
        atField = Circle me.x me.y 100
        (inField, outsideField) = 
            if fieldOn then
                List.partition (\b -> b.from /= Player && circleCollisonTest b.hitbox atField) flyingBullets
            else
                ([], flyingBullets)

        finalBullets = List.map updateXY outsideField

        filteredBullets = List.filter (\b-> b.from == Player) <| List.filter (\value -> not (List.member value allBullets)) bullets
    in
        (finalBullets,filteredBullets,(hitPlayer,inField))


bulletToViewBox : Me -> List Bullet -> List Bullet
bulletToViewBox me bullets=
    List.map (\value->{ value | x=viewBoxMax/2+value.x-me.x,y=viewBoxMax/2 +value.y-me.y}) bullets


updateState : Model -> State
updateState model =
    let
        collideGate = circleRecTest model.myself.hitBox model.map.gate.position.edge
        collideTreasureList = getCollideTreasure model.map.treasure model.myself
        getTreasure = 
            let 
                temp = List.head collideTreasureList
            in
                case temp of
                    Just a ->
                        a
                    Nothing ->
                        treasureInit 
        -- collideTreasure =/
        newState =
            if collideGate then
                NextStage
            else if  not (List.isEmpty collideTreasureList) then
                PickTreasure getTreasure
            else if model.state == Dialogue then
                Dialogue 
            else
                Others
    in
        newState


getCollideTreasure : List Treasure-> Me -> List Treasure
getCollideTreasure treasureList me= 
    let
        -- d1 =Debug.log "treasure" (List.map (\value -> value.material) treasureList)
        treasureRec = List.map (\value -> value.position ) treasureList
        treasure =List.filter (\value -> (circleRecTest me.hitBox value.position.edge) && (value.canShow == True )) treasureList 

        -- d1 =Debug.log "treasure" (List.map (\value -> value.material) treasure)
    in
        treasure


updateDialogues : Model -> Dialogues
updateDialogues model =
    model.currentDialogues

hit : List Bullet -> List Bullet-> Me -> Me
hit bulletHit bulletAT me =
{-    if List.isEmpty bulletHit && List.isEmpty bulletAT then 
        me
    else
-}    let
        totalHurt = bulletHit
                |> List.map .force
                |> List.sum
                |> Basics.round
        attr = me.attr
        health = getCurrentAttr Health attr
        armor = getCurrentAttr Armor attr
        hurtAttr = 
            if totalHurt <= armor then     -- the armor is enough to protect the player
                setCurrentAttr Armor -totalHurt attr
            else if armor > 0 then      -- the armor is broken due to these bullets
                setCurrentAttr Armor -armor attr
                |> setCurrentAttr Health (totalHurt - armor)
            else
                setCurrentAttr Health -(min totalHurt health) attr
        armorRepair = 
            if totalHurt == 0 && modBy 60 me.counter == 0 then
                10
            else
                0
        currentClip = getCurrentAttr Clip attr
        maxClip = getMaxAttr Clip attr
        loseClip = maxClip - currentClip
        catchBullet = List.length bulletAT
        newAttr = setCurrentAttr Clip (min catchBullet loseClip) hurtAttr
                |> setCurrentAttr Armor armorRepair 
    in
        {me | attr = newAttr}


updateDualWield : Model -> Model
updateDualWield model =
    let
        {-
        dual = model.myself.skillSys.subsys
              |> List.filter (\sub -> sub.id == 2)
              |> List.head
              |> Maybe.withDefault subSysBerserker
              |> .skills
              |> List.filter (\s -> s.id == 1 && s.level == 4)
              |> List.head
              |> Maybe.withDefault skillDualWield
              |> .unlocked
        -}
        dual = skillState 2 1 4 model.myself.skillSys.subsys subSysBerserker skillDualWield
        me = model.myself
        newMe =
            if dual && me.dualWield == 0 then
                {me|dualWield = 100}
            else
                me
    in
        {model|myself=newMe}


updateFlashStatus : Model -> Model
updateFlashStatus model =
    let
        flash = skillState 0 0 4 model.myself.skillSys.subsys subSysPhantom skillFlash
        me = model.myself
        newModel =
            if flash && me.flash == 0 then
                let
                    afterFlash = updateFlash model
                    meFlash = {afterFlash|flash = 1}
                in
                    {model|myself = meFlash}
            else
                model
    in
        newModel

updateFlash : Model ->  Me
updateFlash model =
    let
        me = model.myself
        (posX, posY) = me.mouseData
        unitV = sqrt ((posX - 500) * (posX - 500) + (posY - 520) * (posY - 520))
                -- velocity decomposition
        cos = (posX - 500) / unitV
        sin = (posY - 500) / unitV
        minDis_ = Debug.log "minimum distance" (Tuple.second (findMinPath model (posX, posY) 0))
        distance = min minDis_ 200
        newX = distance * cos + me.x
        newY = distance * sin + me.y
    in
        {me|x=newX,y=newY,hitBox=Circle newX newY 20}

updateATField : Model -> Model
updateATField model =
    let
        unlocked = skillState 1 0 4 model.myself.skillSys.subsys subSysMechanic skillAbsoluteTerritoryField
        me = model.myself
        newMe =
            if unlocked && me.absoluteTerrifyField == 0 then
                {me|absoluteTerrifyField = 50}
            else
                me
    in
        {model|myself = newMe}

updateInvisibility : Model -> Model
updateInvisibility model =
    let
        unlocked = skillState 0 1 4 model.myself.skillSys.subsys subSysPhantom skillInvisible
        me = model.myself
        newMe =
            if unlocked && me.invisible == 0 then
                {me|invisible = 50}
            else
                me
    in
        {model|myself = newMe}

placeBomb : Model -> Model
placeBomb model =
    let
<<<<<<< HEAD
        me = model.myself
        newBomb = makeBomb (me.x, me.y)
        newBombs = newBomb :: model.bomb
    in
    {model|bomb = newBombs}

=======
         
        me = model.myself
        skillSys = me.skillSys
        isUnlocked = Skill.skillState 1 1 3 skillSys.subsys subSysMechanic skillDirectionalBlasting
        canUse = me.directionalBlasting == 0
        newBomb = makeBomb (me.x, me.y)
        newBombs = newBomb :: model.bomb
        newMe = {me|directionalBlasting = 1}
    in
    if isUnlocked && canUse then
        {model|bomb = newBombs, myself = newMe}
    else
        model
    
>>>>>>> Wu_Qifei
findMinPath : Model -> (Float, Float)-> Float -> (Model, Float)
findMinPath model (mouseX,mouseY) distance=
    let
        me = model.myself
        posX = mouseX
        posY = mouseY
        unitV = sqrt ((posX - 500) * (posX - 500) + (posY - 520) * (posY - 520))
                -- decomposition
        cos = (posX - 500) / unitV
        sin = (posY - 520) / unitV
        xTemp = 10 * cos
        yTemp = 10 * sin
        newXTemp = xTemp + me.x
        newYTemp = yTemp + me.y
        collideType = wallCollisionTest (Circle newXTemp newYTemp 20) (model.map.obstacles++(List.map (\value->value.position) model.map.walls)++model.map.roads)
        isCollide = not (List.length collideType == 0)
    in
        case isCollide of
            True ->
                (model, distance)
            False ->
                let
                    newModel = {model|myself={me|x=newXTemp,y=newYTemp,hitBox=Circle newXTemp newYTemp 20}}
                    newDistance = Tuple.second (findMinPath newModel (mouseX,mouseY) (distance+10))
                in
                    (newModel, newDistance)


coolSkills : Me -> Me
coolSkills me =
    let
        cool val time =
            if val > 1 then
                val - 1
            else if val == 1 then
                -time
            else if val < 0 then
                val + 1
            else
                0
    in
        {me|dualWield = cool me.dualWield 100
        , flash = cool me.flash 100
        , absoluteTerrifyField = cool me.absoluteTerrifyField 100
        , invisible= cool me.invisible 100
        , directionalBlasting = cool me.directionalBlasting 1200}

updateWeaponChoosing : WeaponChoosingMsg -> Model -> Model
updateWeaponChoosing msg model =
    let
        me = model.myself
        unlockSys = me.weaponUnlockSys
        canUnlock = List.length unlockSys.unlockedWeapons < model.storey
    in
    case msg of
        CloseWindow ->
            let
                newUnlockSys = {unlockSys|active=False}
                newMe = {me|weaponUnlockSys=newUnlockSys}
            in
            {model|state=Others,gameState=Playing,myself=newMe}
        ChoosingWeapon weaponMsg ->
            {model|myself={me|weaponUnlockSys={unlockSys|chosen=weaponMsg}}}
        UnlockWeapon ->
            if canUnlock then
                if not (List.member unlockSys.chosen (List.map (\w -> w.extraInfo) unlockSys.unlockedWeapons)) then
                case unlockSys.chosen of
                    Gatling ->
                        let
                            newWeapon_ = Maybe.withDefault defaultWeapon (List.head (List.drop 1 me.arsenal))
                            newWeapon = {newWeapon_|number=List.length unlockSys.unlockedWeapons + 1}
                            newMe = {me|weapons=List.append me.weapons [newWeapon],weaponUnlockSys={unlockSys|unlockedWeapons=List.append me.weapons [newWeapon]}}
                        in
                            {model|myself=newMe}
                    Mortar ->
                        let
                            newWeapon_ = Maybe.withDefault defaultWeapon (List.head (List.drop 2 me.arsenal))
                            newWeapon = {newWeapon_|number=List.length unlockSys.unlockedWeapons + 1}
                            newMe = {me|weapons=List.append me.weapons [newWeapon],weaponUnlockSys={unlockSys|unlockedWeapons=List.append me.weapons [newWeapon]}}
                        in
                            {model|myself=newMe}
                    Shotgun ->
                        let
                            newWeapon_ = Maybe.withDefault defaultWeapon (List.head (List.drop 3 me.arsenal))
                            newWeapon = {newWeapon_|number=List.length unlockSys.unlockedWeapons + 1}
                            newMe = {me|weapons=List.append me.weapons [newWeapon],weaponUnlockSys={unlockSys|unlockedWeapons=List.append me.weapons [newWeapon]}}
                        in
                            {model|myself=newMe}
                    Pistol ->
                        model
                    NoWeapon ->
                        model
                else
                    model
            else
                model
