module Config exposing (init,viewBoxMax,playerSpeed,myselfConfig,initMapUpdate,bulletSpeed)
import Model exposing (Model,Me)
import Shape exposing (Rectangle, Circle)
<<<<<<< HEAD
import Map.Map exposing (Map,Room)
-- import Map exposing (recInit)
import Random
import Map.MapGenerator exposing (roomGenerator)
import Map.MapDisplay exposing (showMap)
=======
import Map.Map exposing (Map,Room,mapConfig)
-- import Map exposing (recInit)
import Random
import Map.MapGenerator exposing (roomGenerator)
import Map.MapDisplay exposing (mapWithGate)

>>>>>>> Zihao_Wei

-- import Json.Decode exposing (Decoder,map4,at,int,float)

playerSpeed : Float
playerSpeed = 30

bulletSpeed : Float
bulletSpeed = 20

viewBoxMax : Float 
viewBoxMax = 1000

myselfConfig : Me
myselfConfig = Me 0 0 50 playerSpeed 0 0 False False False False (500,500) False (Circle 0 0 50) []

roomInit : (List Room, Random.Seed)
roomInit = 
    roomGenerator 1 (Random.initialSeed 0)

mapInit : Map
<<<<<<< HEAD
mapInit = showMap (Tuple.first roomInit) (List.length (Tuple.first roomInit)) (Map [] [] [] [] [])
=======
mapInit = mapWithGate (Tuple.first roomInit) (List.length (Tuple.first roomInit)) mapConfig (Random.initialSeed 0)
>>>>>>> Zihao_Wei

init : Model
init = Model myselfConfig [] [] mapInit roomInit mapInit

initMapUpdate : Me -> (List Rectangle) -> (List Rectangle)
initMapUpdate me model =
    List.map (\value-> {value|x=me.x + viewBoxMax/2 + value.x, y= me.y + viewBoxMax/2 + value.y}) model
