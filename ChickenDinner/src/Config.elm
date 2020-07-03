module Config exposing (init,viewBoxMax,playerConfig,playerSpeed,myselfConfig,initMapUpdate,bulletConfig,bulletSpeed)
import Model exposing (Model,Player,Me,Rectangle,Bullet,Map,Room)
import Map exposing (recInit)
import Random
import MapGenerator exposing (roomGenerator)
import MapDisplay exposing (showMap)

-- import Json.Decode exposing (Decoder,map4,at,int,float)

playerSpeed : Float
playerSpeed = 500

bulletSpeed : Float
bulletSpeed = 20

viewBoxMax : Float 
viewBoxMax = 1000


playerConfig : Player
playerConfig = Player 0 0 10 0 "Player" 0 False

bulletConfig : Bullet
bulletConfig = Bullet 500 500 5 0 0 False

myselfConfig : Me
myselfConfig = Me 0 0 50 playerSpeed 0 0 False False False False recInit (500,500) False "Me" 0

roomInit : (List Room, Random.Seed)
roomInit = 
    roomGenerator 1 (Random.initialSeed 0)

mapInit : Map
mapInit = showMap (Tuple.first roomInit) (List.length (Tuple.first roomInit)) (Map [] [] [] [] [])

init : Model
init = Model myselfConfig [] [] mapInit roomInit mapInit

initMapUpdate : Me -> (List Rectangle) -> (List Rectangle)
initMapUpdate me model =
    List.map (\value-> {value|x=me.x + viewBoxMax/2 + value.x, y= me.y + viewBoxMax/2 + value.y}) model

-- decoder : Decoder MouseMoveData
-- decoder =
--     map4 MouseMoveData
--         (at [ "offsetX" ] int)
--         (at [ "offsetY" ] int)
--         (at [ "target", "offsetHeight" ] float)
--         (at [ "target", "offsetWidth" ] float)