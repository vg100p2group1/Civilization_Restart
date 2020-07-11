module Config exposing (viewBoxMax,playerSpeed,initMapUpdate,bulletSpeed,roomInit,mapInit)

import Shape exposing (Rectangle, Circle)
import Map.Map exposing (Map,Room)
-- import Map exposing (recInit)
import Random
import Map.MapGenerator exposing (roomGenerator)
import Map.MapDisplay exposing (showMap)

-- import Json.Decode exposing (Decoder,map4,at,int,float)

playerSpeed : Float
playerSpeed = 30

bulletSpeed : Float
bulletSpeed = 20

viewBoxMax : Float 
viewBoxMax = 1000

roomInit : (List Room, Random.Seed)
roomInit = 
    roomGenerator 1 (Random.initialSeed 0)

mapInit : Map
mapInit = showMap (Tuple.first roomInit) (List.length (Tuple.first roomInit)) (Map [] [] [] [] [])

initMapUpdate : (Float, Float) -> (List Rectangle) -> (List Rectangle)
initMapUpdate (x,y) model =
    List.map (\value-> {value|x=x + viewBoxMax/2 + value.x, y= y + viewBoxMax/2 + value.y}) model
