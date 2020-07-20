module Environment.ShowWalls exposing (showWalls)
import Model exposing (Me,Direction(..))
import Messages exposing (Msg(..))
import Svg 
import Svg.Attributes 
import Shape exposing (Rectangle)
import Map.Map exposing (Wall,WallProperty(..))


showWalls : List Wall -> List ( Svg.Svg Msg) 
showWalls walls =
    let
        
        -- d=Debug.log "wall" obstacle
        createBricksFormat oneWall =
           let
                model = oneWall.position
                numColumn = model.height/50
                numRow = model.width/100
                -- d1=Debug.log "num" ((model.height,model.width),(numColumn,numRow))
           in
                case oneWall.property of 
                    UpWall ->
                        rowWall numRow model.x (model.y+150) []
                    DownWall ->
                        rowWall numRow model.x model.y []
                    LeftWall ->
                        columnWall numColumn (model.x+150) model.y []
                    RightWall ->
                        columnWall numColumn model.x model.y []
    in
        List.concat <| List.map createBricksFormat walls




columnWall : Float -> Float -> Float -> List (Svg.Svg Msg) ->  List (Svg.Svg Msg)
columnWall number x y wallList=
    if number <=0 then
        wallList
    else 
       columnWall (number-1) x (y+50) (wallList++[showOneColumnBrick x y])
    
    



showOneColumnBrick : Float -> Float -> Svg.Svg Msg
showOneColumnBrick x y =
    Svg.image 
        [ Svg.Attributes.x <| String.fromFloat x
        , Svg.Attributes.y <| String.fromFloat y
        , Svg.Attributes.xlinkHref "./images/Environment/Wall2.png"
        , Svg.Attributes.preserveAspectRatio "none meet"
        , Svg.Attributes.width <| String.fromFloat 50
        , Svg.Attributes.height <| String.fromFloat 50
        , Svg.Attributes.fill "black"
        ]
    []


rowWall : Float -> Float -> Float -> List (Svg.Svg Msg) ->  List (Svg.Svg Msg)
rowWall number x y wallList=
    if number <=0 then
        wallList
    else 
       rowWall (number-1) (x+100) y (wallList++[showOneRowBrick x y])


showOneRowBrick : Float -> Float -> Svg.Svg Msg
showOneRowBrick x y =
    Svg.image 
        [ Svg.Attributes.x <| String.fromFloat x
        , Svg.Attributes.y <| String.fromFloat y
        , Svg.Attributes.xlinkHref "./images/Environment/Wall1.png"
        , Svg.Attributes.preserveAspectRatio "none meet"
        , Svg.Attributes.width <| String.fromFloat 100
        , Svg.Attributes.height <| String.fromFloat 50
        , Svg.Attributes.fill "black"
        ]
    []