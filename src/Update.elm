module Update exposing (..)
import Messages exposing (Msg(..))
import Model exposing (Model,Me,Rec,Rectangle,recCollisionTest,recUpdate)
import Config exposing (playerSpeed,viewBoxMax)
import Map exposing (recInit)
import Debug
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of

        MoveLeft on ->
            let 
                pTemp =  model.myself 
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

    in
        ({model| myself = newMe, viewbox=newViewbox},Cmd.none)


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
                    (newXspeed/2,newYspeed/2)
                _ ->
                    (newXspeed,newYspeed)
        (xSpeedFinal,ySpeedFinal) = getSpeed
        
        (newX,newY) = (me.x+xSpeedFinal,me.y+ySpeedFinal) --Todo
        recTemp = Rec newX newY (viewBoxMax/2) (viewBoxMax/2)
        
        
    in
        {me|xSpeed=xSpeedFinal,ySpeed=ySpeedFinal,x=newX,y=newY,edge=recTemp}



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


updateViewbox : Me -> Model -> List Rectangle
updateViewbox me model =
    -- let
    --     -- recs = model.walls
    --     -- d1 =Debug.log "Edge" me.edge
    --     -- viewedRecTemp = List.filter (\value -> (recCollisionTest me.edge value.edge)) model.walls
    --     -- d2 =Debug.log "viewedRecTemp" viewedRecTemp
    --     -- left = me.x - viewBoxMax/2
    --     -- right = me.x + viewBoxMax/2
    --     -- top = me.y - viewBoxMax/2
    --     -- bottom = me.y + viewBoxMax/2
        


    --     -- viewRec = List.map viewUpdate viewedRecTemp
    -- in
    let
        d=Debug.log "recs" model.viewbox
    in
        List.map (viewUpdate me) model.viewbox