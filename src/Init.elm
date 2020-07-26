module Init exposing (init)

import Map.MapDisplay exposing (mapInit)
import Map.MapGenerator exposing (roomInit)
import Model exposing (Model, defaultMe, State(..), Sentence, Side(..), Role(..), sentenceInit,mapToViewBox,GameState(..))

init : Model
init =
    let
        (roomNew,mapNew) = mapInit
    in
    
        { myself = defaultMe
        , bullet = []
        , bulletViewbox = []
        , map = mapNew
        , rooms = (roomNew,Tuple.second roomInit)
        , viewbox = mapToViewBox defaultMe mapNew
        , size = (0, 0)
        , state = Others
        , currentDialogues = [{sentenceInit | text = "hello", side = Left}, {sentenceInit | text = "bad", side = Right}, {sentenceInit | text = "badddddd", side = Left}, {sentenceInit | text = "good", side = Right}]
        , explosion = []
        , explosionViewbox = []
        , paused = False
        , gameState = Playing
        , storey = 1
        , isGameOver = False
        }
