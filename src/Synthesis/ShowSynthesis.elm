module Synthesis.ShowSynthesis exposing (showSynthesis)
import Messages exposing (Msg)
import Model exposing (Model)
import Html exposing (Html, div, text, button, progress,img)
import Html.Attributes exposing (style, disabled,src)
import Html.Events exposing (onClick)
import Weapon exposing (Arsenal(..),defaultWeapon)

import Messages exposing (SynthesisMsg(..),Msg(..))



showSynthesis : Model -> Html Msg
showSynthesis model =
    let
        sys = model.myself.synthesis
        weaponNum = sys.weaponNumber
        weapon = model.myself.weapons
        weaponNowTemp = List.head <| List.drop weaponNum weapon 
        weaponNow = 
            case weaponNowTemp of 
                Just a ->
                    a
                _ ->
                    defaultWeapon
        
        getUrl =
            case weaponNow.extraInfo of 
                Pistol -> 
                    "./images/Gun/Gun_1_L.png"
                Gatling ->
                    "./images/Gun/Gun_2_L.png"
                Mortar ->
                    "./images/Gun/Gun_3_L.png"
                Shotgun ->
                    "./images/Gun/Gun_4_L.png"

    in
        if sys.active then
                div
                [ style "background" "rgba(236, 240, 241, 0.89)"
                , style "color" "#34495f"
                , style "height" "400px"
                , style "left" "280px"
                , style "padding" "0 140px"
                , style "position" "absolute"
                , style "top" "155px"
                , style "width" "400px"
                , style "background-size" "100% 100%"
                ]
                [   
                    button [onClick <| SynthesisSystem <| NextWeapon False, style "margin" "20px 0 0 100px",style "float" "left"] [text "<"]
                    , div [][img [src getUrl][]]
                    , button [onClick <| SynthesisSystem <| NextWeapon True,style "margin" "20px 0 0 20px"] [text ">"]
                --     , div [style "margin" "20px 0 0 180px"] [text points]
                --     , div
                --         [style "margin" "40px 0 0 120px"]
                --         (List.map (skillToButton curr.chosen) skills)
                --     , div
                --         [ style "margin" "190px 0 0 0"
                --         , style "padding" "5px 10px 5px 10px"
                --         , style "height" "60px"
                --         , style "background" "#FFF"]
                --         [text txt]
                --     , button
                --         [ onClick <| SkillChange <| UnlockSkill
                --         , style "margin" "20px 0 0 180px"
                --         , disabled (not chosenCanUnlock)
                --         ]
                --         [text "Unlock"]
                ]
        else
            div [] []