module Main exposing (main,subscriptions,key)
import Browser
import Browser.Dom exposing (getViewport)
import Browser.Events exposing (onAnimationFrameDelta,onKeyDown,onKeyUp, onResize)
import Html.Events exposing (keyCode)
import Json.Decode as Decode
import Json.Encode exposing (Value)
import Messages exposing (Msg(..),SkillMsg(..),SynthesisMsg(..))
import Task
import View exposing (view)
import Update
import Model exposing (Model, defaultMe, State(..), Sentence, Side(..), Role(..), sentenceInit,mapToViewBox,GameState(..))
import Map.MapDisplay exposing (mapInit)
import Map.MapGenerator exposing (roomInit)
-- import Html.Styled exposing (..)
-- import Html.Styled.Attributes exposing (..)

-- import Debug
-- import Model exposing (Model)

main : Program Value Model Msg
main =
    Browser.element
        { view =  View.view 
        , init = \value -> (init, Task.perform GetViewport getViewport)
        , update = Update.update        
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ if model.gameState == Playing then
              onAnimationFrameDelta Tick
          else
              Sub.none
        , onKeyUp (Decode.map (key False) keyCode)
        , onKeyDown (Decode.map (key True) keyCode)
        , onResize Resize
        ]

key : Bool -> Int -> Msg
key on keycode =
    case keycode of
        87 ->
            MoveUp on
        65 ->
            MoveLeft on
        68 ->
            MoveRight on       
        83 ->
            MoveDown on
        70 ->
            if on then
                FMsg
            else
                Noop
        13 ->
            if on then
                NextSentence
            else
                Noop
        71 ->
            ShowDialogue
        49 ->
            ChangeWeapon 1
        50 ->
            ChangeWeapon 2
        51 ->
            ChangeWeapon 3
        52 ->
            ChangeWeapon 4
        81 ->
            if on then
                ChangeWeapon_
            else Noop
        66 ->
            if on then
                SkillChange TriggerSkillWindow
            else
                Noop
        82 ->
            if on then
                SynthesisSystem TriggerSynthesisWindow
            else
                Noop

        32 ->
            if on then
                ChangeGameState
            else
                Noop

        _ ->
            Noop

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
        }




