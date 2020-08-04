module Display.DisplayTraining exposing (showTraining)
import Messages exposing (Msg)
import Model exposing (Model,WeaponUnlockSys,State(..))
import Html exposing (Html, div, text, button, progress,img)
import Html.Attributes exposing (style, disabled,src,class)
import Html.Events exposing (onClick)
import Weapon exposing (Arsenal(..),defaultWeapon)

import Messages exposing (SynthesisMsg(..),Msg(..),WeaponChoosingMsg(..))
import Dict exposing (Dict, get)
showTraining: Model -> Html Msg
showTraining model =
    if model.state == OnTraining then
    let
        training = model.trainingSession
        txt =
            Maybe.withDefault "Nothing" (get training.step training.tips)
    in
        div
        [
        --  style "background" "rgba(236, 240, 241, 0.89)"
          style "color" "#34495f"
        , style "height" "100px"
        , style "left" "360px"
        , style "position" "absolute"
        , style "top" "300px"
        , style "width" "300px"
        , style "background-size" "100% 100%"
        ]
        [ div
        [ style "position" "absolute"
        --, style "margin-left" "290px"
        , style "margin-top" "5px"
        , style "color" "blue"
        , style "font-family" "lucida sans unicode,lucida grande, sans-serif"
        , style "text-shadow" "5px 5px 5px #B0E0E6"
        , style "font-size" "25px"
        ]
        [text txt]
        ]
    else
    div [] []

