module Update exposing (update)

import Messages exposing (Msg(..))
import Model exposing (Model,Me,State(..),Direction(..),Dialogues, Sentence, AnimationState,defaultMe,mapToViewBox)
import Shape exposing (Rec,Rectangle,Circle,CollideDirection(..),recCollisionTest,recUpdate,recInit, recCollisionTest,circleRecTest,circleCollisonTest)
import Map.Map exposing (Map,mapConfig)
import Config exposing (playerSpeed,viewBoxMax,bulletSpeed)
import Weapon exposing (Bullet,bulletConfig,ShooterType(..))
import Debug
-- import Svg.Attributes exposing (viewBox)
-- import Html.Attributes exposing (value)
import Map.MapGenerator exposing (roomGenerator)
import Map.MapDisplay exposing (showMap, mapWithGate)
import Map.MonsterGenerator exposing (updateMonster)
import Move.PlayerMoving exposing (playerMove)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of

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
                pTemp =  model.myself
                me= {pTemp | fire = True}
                -- bulletnow = model.bullet
                newShoot = fireBullet me.mouseData (me.x,me.y)
                newBullet = newShoot :: model.bullet 
                -- newBulletViewbox = List.map (\value -> {value| x=500,y=500}) newBullet
            in
                ({model|myself = me, bullet = newBullet},Cmd.none)
        
        MouseUp ->
            let
                pTemp =  model.myself
                me= {pTemp | fire = False}
            in
                ({model|myself = me},Cmd.none) 
        NextFloor ->
            if model.state == NextStage then
                let
                    roomNew =
                        roomGenerator 1 (Tuple.second model.rooms)

                    mapNew = mapWithGate (Tuple.first roomNew) (List.length (Tuple.first roomNew)) mapConfig (Tuple.second model.rooms)
                    meTemp = model.myself
                    meNew = {defaultMe|weapons=meTemp.weapons}
                    -- it should be updated when dialogues are saved in every room
                    newDialogues = updateDialogues model
                in
                    ({model|myself=meNew,rooms=roomNew,map=mapNew,viewbox=mapNew,state=Dialogue,currentDialogues=newDialogues},Cmd.none)
            else
                (model, Cmd.none)
        Tick time ->
            model
                --|> updateSentence (min time 25)
                |> animate


        NextSentence ->
            (updateSentence 0 model, Cmd.none)

        -- the dialogue should be displayed when the player enters a new room actually
        ShowDialogue ->
            ({ model | state = Dialogue}, Cmd.none)


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


        Noop ->
            let 
                pTemp =  model.myself
                me= {pTemp | moveDown = False, moveUp = False, moveRight =False, moveLeft=False}
            in
                ( {model| myself= me}
                , Cmd.none
                )

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




animate :  Model -> (Model, Cmd Msg)
animate  model =
    -- (model,Cmd.none)
    let
        me = model.myself
        
        (newMe,collision) = speedCase me model.map

        (newMonsters,newBullet) = updateMonster model.map.monsters model.bullet me
        map = model.map
        newMap = {map | monsters = newMonsters}

        newViewbox = mapToViewBox newMe newMap
        newBulletList = updateBullet newMe model.map (List.append model.bullet newBullet) collision
        newBulletListViewbox = bulletToViewBox newMe newBulletList
        newState = updateState model
    in
        ({model| myself = {newMe|counter=newMe.counter+1,url=playerMove newMe}, viewbox=newViewbox, map = newMap, bullet= newBulletList,bulletViewbox=newBulletListViewbox,state = newState},Cmd.none)


speedCase : Me -> Map-> (Me,(Bool,Bool))
speedCase me map= 
    let 
        getNewXSpeed =
            if me.moveLeft then 
                (True,-playerSpeed)
            else
                if me.moveRight then
                  (True,playerSpeed)
                else
                    (False,0)
        
        (horizontal,newXspeed)=getNewXSpeed
        
        getNewYSpeed =  
            if me.moveUp then 
                (True,-playerSpeed)
            else
                if me.moveDown then
                  (True,playerSpeed)
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

        collideType = wallCollisionTest (Circle newXTemp newYTemp 50) (map.obstacles++map.walls++map.roads) 
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
        ({me|xSpeed=xSpeedFinal,ySpeed=ySpeedFinal,x=newX,y=newY,hitBox=(Circle newX newY 50)},(collisionX,collisionY))

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
                (state, newDialogues) =
                    if end then
                        (Others, model.currentDialogues)
                    else
                        (Dialogue, List.drop 1 model.currentDialogues)
            in
                {model | state = state, currentDialogues = newDialogues}
        _ ->
            model

fireBullet : (Float, Float) -> (Float, Float) -> Bullet
fireBullet (mouseX,mouseY) (meX, meY) =
    let
        posX = mouseX
        posY = mouseY

        -- d1=Debug.log "mouse" (posX,posY)
        -- d2=Debug.log "me" (meX,meY)
        unitV = sqrt ((posX - 500) * (posX - 500) + (posY - 500) * (posY - 500)) 
        xTemp = bulletSpeed / unitV * (posX - 500)
        yTemp = bulletSpeed / unitV * (posY - 500)
        newCircle = Circle meX meY 5
    in
        {bulletConfig | x=meX,y=meY,hitbox = newCircle, speedX=xTemp, speedY=yTemp}

updateBullet : Me-> Map -> List Bullet -> (Bool,Bool) -> List Bullet
updateBullet me map bullets (collisionX,collisionY) =
    let
        updateXY b =
            let
                d2=Debug.log "meX" me.xSpeed
                newX = 
                    if (b.from == Player) && (not collisionX) then 
                        b.hitbox.cx + b.speedX + me.xSpeed
                    else 
                        b.hitbox.cx + b.speedX
                newY = 
                    if (b.from == Player) && (not collisionY) then
                        b.hitbox.cy + b.speedY + me.ySpeed
                    else 
                        b.hitbox.cy + b.speedY
                newHitbox = Circle newX newY b.hitbox.r
            in
                {b|hitbox = newHitbox,x=newX, y=newY}

        allBullets = bullets
                    |> List.filter (\b -> not (List.any (circleRecTest b.hitbox) (List.map .edge map.walls)))
                    |> List.filter (\b -> not (List.any (circleRecTest b.hitbox) (List.map .edge map.obstacles)))
                    |> List.filter (\b -> not (List.any (circleRecTest b.hitbox) (List.map .edge map.doors)))
                    |> List.filter (\b -> (not (List.any (circleCollisonTest b.hitbox) (List.map .position map.monsters)))||(b.from == Monster))
        finalBullets = List.map updateXY allBullets
    in
        finalBullets


bulletToViewBox : Me -> List Bullet -> List Bullet
bulletToViewBox me bullets=
    List.map (\value->{ value | x=viewBoxMax/2+value.x-me.x,y=viewBoxMax/2 +value.y-me.y}) bullets


updateState : Model -> State
updateState model =
    let
        collideGate = circleRecTest model.myself.hitBox model.map.gate.edge
        newState =
            if collideGate then
                NextStage
            else if model.state == Dialogue then
                Dialogue
            else
                Others
    in
        newState

updateDialogues : Model -> Dialogues
updateDialogues model =
    model.currentDialogues