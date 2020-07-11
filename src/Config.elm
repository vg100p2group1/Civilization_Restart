
module Config exposing (init,viewBoxMax,playerSpeed,myselfConfig,initMapUpdate,bulletSpeed,sentenceInit)
import Model exposing (Model,Me,State(..), Dialogues, Sentence, Side(..), Role(..), AnimationState)
import Shape exposing (Rectangle, Circle)
import Map.Map exposing (Map,Room,mapConfig)
-- import Map exposing (recInit)
import Random
import Map.MapGenerator exposing (roomGenerator)
import Map.MapDisplay exposing (mapWithGate)


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

mapInit = mapWithGate (Tuple.first roomInit) (List.length (Tuple.first roomInit)) mapConfig (Random.initialSeed 0)

sentenceInit : Sentence
sentenceInit = Sentence "Enjoy the game now!" Bottom Monster False 0 "url(background1.jpg)"

init : Model
init =
    { myself = myselfConfig
    , bullet = []
    , bulletViewbox = []
    , map = mapInit
    , rooms = roomInit
    , viewbox = mapInit
    , size = (0, 0)
    , state = Others
    , currentDialogues = [{sentenceInit | text = "hello", side = Left}, {sentenceInit | text = "bad", side = Right}, {sentenceInit | text = "badddddd", side = Left}, {sentenceInit | text = "good", side = Right}]
    }

--init = Model myselfConfig [] [] mapInit roomInit mapInit Others [{sentenceInit | text = "hello"}, {sentenceInit | text = "bad"}, {sentenceInit | text = "badddddd"}, {sentenceInit | text = "good"] False False



initMapUpdate : Me -> (List Rectangle) -> (List Rectangle)
initMapUpdate me model =
    List.map (\value-> {value|x=me.x + viewBoxMax/2 + value.x, y= me.y + viewBoxMax/2 + value.y}) model
