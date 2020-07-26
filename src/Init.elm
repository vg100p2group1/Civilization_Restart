module Init exposing (init)

import Map.MapDisplay exposing (mapInit)
import Map.MapGenerator exposing (roomInit)
import Model exposing (Model, defaultMe, State(..), Sentence, Side(..), Role(..), sentenceInit,mapToViewBox,GameState(..))

init : Model
init =
    { myself = defaultMe
    , bullet = []
    , bulletViewbox = []
    , map = mapInit
    , rooms = roomInit
    , viewbox = mapToViewBox defaultMe mapInit
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
