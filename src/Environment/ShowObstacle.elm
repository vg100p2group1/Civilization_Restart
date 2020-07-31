module Environment.ShowObstacle exposing (showObstacle)
import Svg 
import Svg.Attributes 
import Shape exposing (Rectangle,recInit)
import Map.Map exposing (Obstacle)
import Model exposing (Model,Me)
import Messages exposing (Msg)

showObstacle : List Rectangle -> List (Svg.Svg Msg)
showObstacle obstacles =
    showObstacles obstacles (List.length obstacles) []

showObstacles : (List Rectangle) -> Int -> List (Svg.Svg Msg) -> List (Svg.Svg Msg)
showObstacles obstacleLeft number svgList =
    let
        obstacleNowTemp = List.head obstacleLeft
        obstacleLeftNew = List.drop 1 obstacleLeft 
        obstacleNow = 
            case obstacleNowTemp of
                Just a ->
                    a
                _ ->
                    Rectangle 0 0 0 0 recInit
        
        svgNew = svgList ++ (showOneObstacle obstacleNow)

    in
        if (number==0) then
            svgList
        else 
            showObstacles obstacleLeftNew (number-1) svgNew

showOneObstacle : Rectangle -> List (Svg.Svg Msg)
showOneObstacle rect=
    let
        x = rect.x
        y=  rect.y
        w= rect.width
        h= rect.height

        numX = (w  / 50)-1
        numY = h / 50 
        -- d1=Debug.log "num" (numX,numY)
        obstacleFloor = showWalls x numX x y numX numY [] 
        -- obstacleFloor = showOneRectangle xBegin yBegin 
    in
        obstacleFloor

showWalls : Float -> Float -> Float -> Float -> Float -> Float -> List (Svg.Svg Msg) -> List (Svg.Svg Msg)
showWalls xBegin numXBegin x y numX numY svgList=
    if numY==0 then
        svgList
    else 
       if numX==0 then
            showWalls xBegin numXBegin xBegin (y+50) numXBegin (numY-1) (svgList ++ [showOneWall x y])
       else 
            showWalls xBegin numXBegin (x+50) y (numX-1) numY (svgList++[showOneWall x y])
    
    



showOneWall : Float -> Float -> Svg.Svg Msg
showOneWall x y =
        Svg.use [Svg.Attributes.xlinkHref "#Wall2"
                ,Svg.Attributes.x <| String.fromFloat x
                ,Svg.Attributes.y <| String.fromFloat y][]