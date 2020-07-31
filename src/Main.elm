module Main exposing (main,subscriptions,key)
import Browser
import Browser.Dom exposing (getViewport)
import Browser.Events exposing (onAnimationFrameDelta,onKeyDown,onKeyUp, onResize)
import Html.Events exposing (keyCode)
import Json.Decode as Decode
import Json.Encode exposing (Value)
import Messages exposing (Msg(..),SkillMsg(..),SynthesisMsg(..),ShiftMsg(..))
import Task
import View exposing (view)
import Update
import Model exposing (Model, defaultMe, State(..), Sentence, Side(..), Role(..), sentenceInit,mapToViewBox,GameState(..))
import Init exposing (init)
import Time exposing (..)
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
        , Time.every 50 Tictoc
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
            if on then
                DualWield
            else
                Noop
        50 ->
            if on then
                Flash
            else
                Noop
        51 ->
            if on then
                ATField
            else
                Noop        
        52 ->
            if on then
                Invisibility
            else
                Noop 
        69 ->
            if on then
                ChangeWeapon Previous
            else
                Noop
        81 ->
            if on then
                ChangeWeapon Next
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




