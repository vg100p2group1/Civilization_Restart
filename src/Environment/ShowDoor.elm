module Environment.ShowDoor exposing (showDoor)
import Svg 
import Svg.Attributes 
import Shape exposing (Rectangle,recInit)
import Map.Map exposing (Door)
import Model exposing (Model,Me)
import Messages exposing (Msg)
import Environment.ShowFloor exposing (showFloor)

showDoor : List Door -> List (Svg.Svg Msg)
showDoor doors =
    -- let
    --      d1=Debug.log "door" doors 
    -- in
    showDoors doors (List.length doors) []

showDoors : (List Door) -> Int -> List (Svg.Svg Msg) -> List (Svg.Svg Msg)
showDoors doorLeft number svgList =
    let
       
        doorNowTemp = List.head doorLeft
        doorLeftNew = List.drop 1 doorLeft 
        
        
        doorNow = 
            case doorNowTemp of
                Just a ->
                    a
                _ ->
                    Door (Rectangle 0 0 0 0 recInit) False
        -- d1 = Debug.log "door" doorNow
        svgNew = svgList ++ (showOneDoor doorNow)

    in
        if (number==0) then
            svgList
        else 
            showDoors doorLeftNew (number-1) svgNew

showOneDoor : Door -> List (Svg.Svg Msg)
showOneDoor door=
    let
        -- d1 = Debug.log "door" door
        rect = door.position
        x = rect.x
        y=  rect.y
        w= rect.width
        h= rect.height

        numX = w / 50
        numY = h / 50 
        -- d1=Debug.log "num" (numX,numY)
        doorFloor = 
            if door.enable then 
                if numX>numY then 
                    showFloors x numX x y numX numY [] ++  showWallsX x y numY [] 
                else 
                    showFloors x numX x y numX numY [] ++  showWallsY x y numX  [] 
            else 
                showFloors x numX x y numX numY [] 
        -- doorFloor = showOneRectangle xBegin yBegin 
    in
        doorFloor



showFloors : Float -> Float -> Float -> Float -> Float -> Float -> List (Svg.Svg Msg) -> List (Svg.Svg Msg)
showFloors xBegin numXBegin x y numX numY svgList=
    if numY==0 then
        svgList
    else 
       if numX==0 then
            showFloors xBegin numXBegin xBegin (y+50) numXBegin (numY-1) (svgList ++ [showOneFloor x y])
       else 
            showFloors xBegin numXBegin (x+50) y (numX-1) numY (svgList++[showOneFloor x y])
    
    



showOneFloor : Float -> Float -> Svg.Svg Msg
showOneFloor x y =
        Svg.use [Svg.Attributes.xlinkHref "#Floor"
                ,Svg.Attributes.x <| String.fromFloat x
                ,Svg.Attributes.y <| String.fromFloat y][]



showWallsX :  Float  -> Float -> Float -> List (Svg.Svg Msg) -> List (Svg.Svg Msg)
showWallsX x y numY svgList=
    if numY==0 then
        svgList
    else 
        showWallsX x (y+50) (numY-1) (svgList ++ [showOneWallX x y])
    

showWallsY :  Float -> Float  -> Float -> List (Svg.Svg Msg) -> List (Svg.Svg Msg)
showWallsY  x y numX  svgList=
    if numX==0 then
        svgList
    else 
        showWallsY (x+50) y (numX-1)  (svgList ++ [showOneWallY x y])




showOneWallX : Float -> Float -> Svg.Svg Msg
showOneWallX x y =
        Svg.use [Svg.Attributes.xlinkHref "#Laser2"
                ,Svg.Attributes.x <| String.fromFloat x
                ,Svg.Attributes.y <| String.fromFloat y][]

showOneWallY : Float -> Float -> Svg.Svg Msg
showOneWallY x y =
        Svg.use [Svg.Attributes.xlinkHref "#Laser1"
                ,Svg.Attributes.x <| String.fromFloat x
                ,Svg.Attributes.y <| String.fromFloat y][]