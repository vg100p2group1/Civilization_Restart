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

        getUrl = 
            case (round w) of 
                100 ->
                    "#Obstacle1"
                400 ->
                    "#Obstacle2"
                _ ->
                    "#Obstacle3"
    in
       [Svg.use [Svg.Attributes.xlinkHref getUrl
                ,Svg.Attributes.x <| String.fromFloat x
                ,Svg.Attributes.y <| String.fromFloat y][] ]
