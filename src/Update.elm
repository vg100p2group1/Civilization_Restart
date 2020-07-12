module Update exposing (update)

import Messages exposing (Msg(..))
import Model exposing (Model,Me,State(..),Dialogues, Sentence, AnimationState)
import Shape exposing (Rec,Rectangle,Circle,recCollisionTest,recUpdate,recInit)
import Map.Map exposing (Map,mapConfig)
import Config exposing (playerSpeed,viewBoxMax)
import Weapon exposing (Bullet, fireBullet, updateBullet)
import Debug
-- import Svg.Attributes exposing (viewBox)
-- import Html.Attributes exposing (value)
import Map.MapGenerator exposing (roomGenerator)
import Map.MapDisplay exposing (showMap, mapWithGate)
import Map.MonsterGenerator exposing (updateMonster)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of

        MoveLeft on ->
            let 
                pTemp = model.myself 
                me= {pTemp | moveLeft = on, moveRight =  False}
            in
                ( {model| myself= me}
                , Cmd.none
                )

        MoveRight on ->
            let 
                pTemp =  model.myself
                me= {pTemp | moveRight = on, moveLeft = False}
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
                d2 = Debug.log "mePos" (pTemp.x,pTemp.y)
                d = Debug.log "mouse" newMouseData 
                me = {pTemp | mouseData = mouseDataUpdate model newMouseData}
            in 
                ({model|myself = me},Cmd.none)
        
        MouseDown ->
            let
                pTemp =  model.myself
                me= {pTemp | fire = True}
                -- bulletnow = model.bullet
                newShoot = fireBullet me.mouseData (me.x,me.y)
                newBullet = newShoot :: model.bullet 
                newCircle = Circle 500 500 newShoot.hitbox.r
                newBulletViewbox = {newShoot|hitbox = newCircle, x = 500, y = 500, r = 5} :: model.bulletViewbox
                -- newBulletViewbox = List.map (\value -> {value| x=500,y=500}) newBullet
            in
                ({model|myself = me, bullet = newBullet,bulletViewbox=newBulletViewbox},Cmd.none)
        
        MouseUp ->
            let
                pTemp =  model.myself
                me= {pTemp | fire = False}
            in
                ({model|myself = me},Cmd.none) 
        NextFloor ->
            let
                roomNew = 
                    roomGenerator 1 (Tuple.second model.rooms)

                mapNew = mapWithGate (Tuple.first roomNew) (List.length (Tuple.first roomNew)) mapConfig (Tuple.second model.rooms)
            in
                ({model|rooms=roomNew,map=mapNew,viewbox=mapNew},Cmd.none)

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
        
        xLeft = (w - configwidth*r) / 2 
        yTop = (h - configheight*r) / 2

        (mx,my) = 
            mousedata 

    in
        (mx - xLeft, my - yTop)




animate :  Model -> (Model, Cmd Msg)
animate  model =
    let
        me = model.myself
        newMe = speedCase me
        (newMonsters,newBullet) = updateMonster model.map.monsters model.bullet model.map.obstacles me
        map = model.map
        newMap = {map | monsters = newMonsters}
        viewbox = model.viewbox
        (newMonstersViewbox,newBulletViewbox) = updateMonster model.viewbox.monsters model.bulletViewbox model.map.obstacles me 
        newViewbox_ = {viewbox | monsters = newMonstersViewbox}
        newViewbox = updateViewbox newMe {model | viewbox = newViewbox_}
        newBulletList = updateBullet model.map newBullet
        newBulletListViewbox = updateBullet model.viewbox model.bulletViewbox
    in
        ({ model| myself = newMe, viewbox=newViewbox, map = newMap, bullet= newBulletList,bulletViewbox=newBulletListViewbox },Cmd.none)


speedCase : Me -> Me
speedCase me = 
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
        (xSpeedFinal,ySpeedFinal) = getSpeed
        
        (newX,newY) = (me.x+xSpeedFinal,me.y+ySpeedFinal) --Todo
        recTemp = Rec newX newY (viewBoxMax/2) (viewBoxMax/2)
        
        
    in
        {me|xSpeed=xSpeedFinal,ySpeed=ySpeedFinal,x=newX,y=newY,hitBox=(Circle newX newY 50)}



viewUpdate : Me -> Rectangle -> Rectangle
viewUpdate me oneWall =
    let
        -- x = max oneWall.x left
        -- y = max oneWall.y top  
        
        -- width = min oneWall.width (right - x)
        -- height = min oneWall.height (bottom - y)
        xTemp = oneWall.x - me.xSpeed
        yTemp = oneWall.y - me.ySpeed
        recTemp = Rectangle xTemp yTemp oneWall.width oneWall.height recInit
    in
        recUpdate recTemp
        
viewUpdateCircle : Me -> Circle -> Shape.Circle
viewUpdateCircle me circle =
    let 
        xTemp = circle.cx - me.xSpeed
        yTemp = circle.cy - me.ySpeed
    in
        Circle xTemp yTemp circle.r


updateViewbox : Me -> Model -> Map
updateViewbox me model =
    -- viewRec = List.map viewUpdate viewedRecTemp
    -- in
    -- let
    --     meTemp = model.myself
    --     d = Debug.log "mouse2" meTemp.mouseData 
    --     d=Debug.log "recs" model.viewbox
    -- in
    let
        mapTemp = model.viewbox
        newWalls = List.map (viewUpdate me) mapTemp.walls
        newRoads = List.map (viewUpdate me) mapTemp.roads
        newDoors = List.map (viewUpdate me) mapTemp.doors
        newObstacles = List.map (viewUpdate me) mapTemp.obstacles

        newMonsters = List.map (\value -> {value| position = viewUpdateCircle me value.position,region = viewUpdate me value.region}) mapTemp.monsters 

        newGate = viewUpdate me mapTemp.gate

    in
        {mapTemp| walls = newWalls, roads = newRoads,doors=newDoors,obstacles=newObstacles,monsters=newMonsters,gate=newGate}



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

