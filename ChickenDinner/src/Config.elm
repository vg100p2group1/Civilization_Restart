module Config exposing (init,viewBoxMax,playerConfig,playerSpeed,myselfConfig,initMapUpdate)
import Model exposing (Model,Player,Me,Rectangle)
import Map exposing (mapWalls,recInit)
playerSpeed : Float
playerSpeed = 10

viewBoxMax : Float 
viewBoxMax = 1000

playerConfig : Player
playerConfig = Player 0 0 playerSpeed 0

myselfConfig : Me
myselfConfig = Me 0 0 10 playerSpeed 0 0 False False False False recInit

init : Model
init = Model  mapWalls [] myselfConfig  (initMapUpdate myselfConfig mapWalls)

initMapUpdate : Me -> (List Rectangle) -> (List Rectangle)
initMapUpdate me model =
    List.map (\value-> {value|x=me.x + viewBoxMax/2 + value.x, y= me.y + viewBoxMax/2 + value.y}) model