module Synthesis.ShowSynthesis exposing (showSynthesis)
import Messages exposing (Msg)
import Model exposing (Model)
import Html exposing (Html, div, text, button, progress,img)
import Html.Attributes exposing (style, disabled,src)
import Html.Events exposing (onClick)
import Weapon exposing (Arsenal(..),defaultWeapon)

import Messages exposing (SynthesisMsg(..),Msg(..))
import Synthesis.WeaponUpgrade exposing (getWeaponMaterial)


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
        
        package = model.myself.package
        materialNeeded = getWeaponMaterial weaponNow

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
                    button [onClick <| SynthesisSystem <| NextWeapon False, style "float" "left"] [text "<"]
                    , div [ ][img [style "width" "50px",style "height" "50px",src getUrl][]]
                    , button [onClick <| SynthesisSystem <| NextWeapon True] [text ">"]
                    , div [] [text ("Level: "++String.fromInt weaponNow.level)]
                    , div [][text ("steel: " ++ String.fromInt materialNeeded.steel ++ "/" ++String.fromInt package.steel)]
                    , div [][text ("copper: " ++ String.fromInt materialNeeded.copper ++ "/" ++String.fromInt package.copper)]
                    , div [][text ("Wolfram: " ++ String.fromInt materialNeeded.wolfram ++ "/" ++String.fromInt package.wolfram)]
                    , div [][text ("steel: " ++ String.fromInt materialNeeded.wolfram ++ "/" ++String.fromInt package.wolfram)]

                    , button [onClick <| SynthesisSystem <| Synthesis] [text "Synthesis/Upgrade"]
                    , div [][text("tip: "++sys.tip)]
                ]
        else
            div [] []