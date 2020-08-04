module Init exposing (init)

import Map.MapDisplay exposing (mapInit)
import Map.MapGenerator exposing (roomInit)
import Model exposing (Model, defaultMe, State(..), Role(..), mapToViewBox,GameState(..),Page(..),defaultTraining)
import Dialogs exposing (initdialog)

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
        , state = OnTraining
        , currentDialogues =initdialog
        , explosion = []
        , explosionViewbox = []
        , paused = False
        , gameState = Playing
        , storey = 1
        , isGameOver = False
        , pageState = WelcomePage
        , bomb = []
        , wholeCounter = 0
        , trainingSession = defaultTraining
        , isWin = False
        }


