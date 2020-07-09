module Update exposing (update)

import Messages exposing (Msg(..))
import Model exposing (Model,Me)
import Shape exposing (Rec,Rectangle,Circle,recCollisionTest,recUpdate,recInit)
import Map.Map exposing (Map)
import Config exposing (playerSpeed,viewBoxMax)
import Weapon exposing (Bullet, fireBullet, updateBullet)
import Debug
import Map.MapGenerator exposing (roomGenerator)
import Map.MapDisplay exposing (showMap)
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
                -- d2 = Debug.log "mePos" (pTemp.x,pTemp.y)
                -- d = Debug.log "mouse" newMouseData 
                me = {pTemp | mouseData = newMouseData}
                
            in 
                ({model|myself = me},Cmd.none)
        
        MouseDown ->
            let
                pTemp =  model.myself
                me= {pTemp | fire = True}
                -- bulletnow = model.bullet
                newShoot = fireBullet me.mouseData me.hitbox.x me.hitbox.y
                newBullet = model.bullet :: newShoot
                newCircle = Circle 500 500 newShoot.hitbox.r
                newBulletViewbox = model.bulletViewbox :: {newShoot|hitbox = newCircle}
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

                mapNew = showMap (Tuple.first roomNew) (List.length (Tuple.first roomNew)) (Map [] [] [] [] [])
            in
                ({model|rooms=roomNew,map=mapNew,viewbox=mapNew},Cmd.none)

        Tick time ->
           animate model

        Noop ->
            let 
                pTemp =  model.myself
                me= {pTemp | moveDown = False, moveUp = False, moveRight =False, moveLeft=False}
            in
                ( {model| myself= me}
                , Cmd.none
                )


animate :  Model -> (Model, Cmd Msg)
animate  model =
    let 
        me = model.myself
        newMe = speedCase me
        newViewbox = updateViewbox newMe model
        newBullet = updateBullet model.bullet
        newBulletViewbox = updateBullet model.bulletViewbox
    in
        ({model| myself = newMe, viewbox=newViewbox,bullet= newBullet,bulletViewbox=newBulletViewbox},Cmd.none)


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
        newMonsters = List.map (\value -> {value| position = viewUpdate me value.position}) mapTemp.monsters 

    in
        {mapTemp| walls = newWalls, roads = newRoads,doors=newDoors,obstacles=newObstacles,monsters=newMonsters}