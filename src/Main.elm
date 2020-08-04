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
        -- W
        87 ->
            MoveUp on
        -- A
        65 ->
        -- S
            MoveLeft on
        -- D
        68 ->
            MoveRight on
        -- S
        83 ->
            MoveDown on
        -- F
        70 ->
            if on then
                FMsg
            else
                Noop
        -- Enter
        13 ->
            if on then
                NextMsg
            else
                Noop
        -- C
        67 ->
            ShowDialogue
        -- 1
        49 ->
            if on then
                DualWield
            else
                Noop
        -- 2
        50 ->
            if on then
                Flash
            else
                Noop
        -- 3
        51 ->
            if on then
                ATField
            else
                Noop
        -- 4
        52 ->
            if on then
                Invisibility
            else
                Noop
        -- 5
        53 ->
            if on then
                PlaceBomb
            else
                Noop
        -- E
        69 ->
            if on then
                ChangeWeapon Previous
            else
                Noop
        -- Q
        81 ->
            if on then
                ChangeWeapon Next
            else Noop
        -- B
        66 ->
            if on then
                SkillChange TriggerSkillWindow
            else
                Noop
        -- V
        86 ->
            if on then
                SynthesisSystem TriggerSynthesisWindow
            else
                Noop
        -- SpaceBar
        32 ->
            if on then
                ChangeGameState
            else
                Noop
        -- G
        71 ->
            if on then
                UnlockTrigger
            else
                Noop
        -- R
        82 ->
            if on then
                Exit
            else
                Noop
        _ ->
            Noop




