module Synthesis.ShowSynthesis exposing (showSynthesis)
import Messages exposing (Msg)
import Model exposing (Model)
import Html exposing (Html, div, text, button, progress,img)
import Html.Attributes exposing (style, disabled,src,class)
import Html.Events exposing (onClick)
import Weapon exposing (Arsenal(..),defaultWeapon)

import Messages exposing (SynthesisMsg(..),Msg(..))
import Synthesis.WeaponUpgrade exposing (getWeaponMaterial)
import Synthesis.Material exposing (bulletNeeded)


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
                    "./images/Gun/Pistol.png"
                Gatling ->
                    "./images/Gun/Gatling.png"
                Mortar ->
                    "./images/Gun/Mortar.png"
                Shotgun ->
                    "./images/Gun/Shotgun.png"
                NoWeapon ->
                    ""
        
        getName =
            case weaponNow.extraInfo of 
                Pistol -> 
                    "Pistol"
                Gatling ->
                    "Gatling"
                Mortar ->
                    "Mortar"
                Shotgun ->
                    "Shotgun"
                NoWeapon ->
                    ""
        
        package = model.myself.package
        materialNeeded = getWeaponMaterial weaponNow

    in
        if sys.active then
                div
                [ style "background" "rgba(236, 240, 241, 0.89)"
                , style "color" "#34495f"
                , style "height" "400px"
                , style "left" "140px"
                -- , style "padding" "0 140px"
                , style "position" "absolute"
                , style "top" "155px"
                , style "width" "680px"
                , style "background-size" "100% 100%"
                ]
                [    div [style "position" "absolute",style "margin-left" "200px",style "margin-top" "5px", style "color" "red",style "font-size" "25px"] [text "Upgrade & Synthesis System"]
                    , div[][ button [class "btn btn-primary btn-ghost btn-shine", style "color" "black",style "margin-left" "40px",style "margin-top" "40px",style "width" "100px", style "height" "30px",onClick <| SynthesisSystem <| NextWeapon False] [text "<"]
                    , div [style "position" "absolute",style "margin-left" "230px",style "margin-top" "-25px",style "font-size" "15px"] [text ("Upgrade: "++getName)]
                    , div [style "position" "absolute",style "margin-left" "430px",style "margin-top" "-25px",style "font-size" "15px"] [text ("Level: "++String.fromInt weaponNow.level)]

                    , div [style "width" "100px",style "height" "110px" ][img [style "margin-left" "40px",style "margin-top" "10px",style "width" "100px",style "height" "100px",src getUrl][]]
                    , button [class "btn btn-primary btn-ghost btn-shine", style "color" "black",style "margin-left" "40px",style "margin-top" "10px",style "width" "100px", style "height" "30px",onClick <| SynthesisSystem <| NextWeapon True] [text ">"]
                    
                    
                    
                    , div[style "margin-top" "-120px" , style "padding-left" "170px",style "width" "80px",style "height" "80px"]
                        [ div [style "width" "50px",style "height" "50px"][img [style "margin-left" "15px",style "width" "50px",style "height" "50px",src "./images/Material/Iron.jpg"][]]
                         ,div [style "width" "100px",style "height" "20px",style "margin-left" "5px",style "margin-top" "5px"][text ("steel:"  ++String.fromInt package.steel ++ "/" ++ String.fromInt materialNeeded.steel)]]

                    , div[style "margin-top" "-80px" , style "padding-left" "270px",style "width" "80px",style "height" "80px"]
                        [ div [style "width" "50px",style "height" "50px"][img [style "margin-left" "15px",style "width" "50px",style "height" "50px",src "./images/Material/Copper.jpg"][]]
                         ,div [style "width" "100px",style "height" "20px",style "margin-top" "5px"][text ("copper:" ++ String.fromInt package.copper ++ "/" ++ String.fromInt materialNeeded.copper )]]
                    
                    , div[style "margin-top" "-80px" , style "padding-left" "370px",style "width" "80px",style "height" "80px"]
                        [ div [style "width" "50px",style "height" "50px"][img [style "margin-left" "15px",style "width" "50px",style "height" "50px",src "./images/Material/Wolfram.png"][]]
                         ,div [style "width" "100px",style "height" "20px",style "margin-top" "5px"][text ("Wolfram:"  ++String.fromInt package.wolfram ++ "/" ++ String.fromInt materialNeeded.wolfram)]]
                    
                    , div[style "margin-top" "-80px" , style "padding-left" "470px",style "width" "80px",style "height" "80px"]
                        [ div [style "width" "50px",style "height" "50px"][img [style "margin-left" "15px",style "width" "50px",style "height" "50px",src "./images/Material/Uranium.png"][]]
                         ,div [style "width" "100px",style "height" "20px",style "margin-top" "5px"][text ("Uranium:" ++String.fromInt package.uranium ++ "/" ++ String.fromInt materialNeeded.uranium)]]
                    , button [ class "btn btn-primary btn-ghost btn-shine",style "color" "black",style "position" "absolute",style "margin-top" "-90px" , style "margin-left" "580px",style "width" "90px",style "height" "80px",onClick <| SynthesisSystem <| Synthesis] [text "Upgrade"]
                    ]
                    --Bullet
                    , div[style "margin-top" "50px"][ 
                      div [style "position" "absolute",style "margin-left" "230px",style "margin-top" "-15px",style "font-size" "15px"] [text "Bullet Synthesis: 30 per group"]

                    , div [style "width" "100px",style "height" "110px" ][img [style "margin-left" "40px",style "margin-top" "10px",style "width" "100px",style "height" "100px",src "./images/Gun/BulletUI.png"][]]
                                        
                    , div[style "margin-top" "-80px" , style "padding-left" "170px",style "width" "80px",style "height" "80px"]
                        [ div [style "width" "50px",style "height" "50px"][img [style "margin-left" "15px",style "width" "50px",style "height" "50px",src "./images/Material/Iron.jpg"][]]
                         ,div [style "width" "100px",style "height" "20px",style "margin-left" "5px",style "margin-top" "5px"][text ("steel:"  ++String.fromInt package.steel ++ "/" ++ String.fromInt bulletNeeded.steel)]]

                    , div[style "margin-top" "-80px" , style "padding-left" "270px",style "width" "80px",style "height" "80px"]
                        [ div [style "width" "50px",style "height" "50px"][img [style "margin-left" "15px",style "width" "50px",style "height" "50px",src "./images/Material/Copper.jpg"][]]
                         ,div [style "width" "100px",style "height" "20px",style "margin-top" "5px"][text ("copper:" ++ String.fromInt package.copper ++ "/" ++ String.fromInt bulletNeeded.copper )]]
                    
                    , div[style "margin-top" "-80px" , style "padding-left" "370px",style "width" "80px",style "height" "80px"]
                        [ div [style "width" "50px",style "height" "50px"][img [style "margin-left" "15px",style "width" "50px",style "height" "50px",src "./images/Material/Wolfram.png"][]]
                         ,div [style "width" "100px",style "height" "20px",style "margin-top" "5px"][text ("Wolfram:"  ++String.fromInt package.wolfram ++ "/" ++ String.fromInt bulletNeeded.wolfram)]]
                    
                    , div[style "margin-top" "-80px" , style "padding-left" "470px",style "width" "80px",style "height" "80px"]
                        [ div [style "width" "50px",style "height" "50px"][img [style "margin-left" "15px",style "width" "50px",style "height" "50px",src "./images/Material/Uranium.png"][]]
                         ,div [style "width" "100px",style "height" "20px",style "margin-top" "5px"][text ("Uranium:" ++String.fromInt package.uranium ++ "/" ++ String.fromInt bulletNeeded.uranium)]]

                    , button [ class "btn btn-primary btn-ghost btn-shine",style "position" "absolute",style "margin-top" "-90px" , style "color" "black",style "margin-left" "580px",style "width" "90px",style "height" "80px",onClick <| SynthesisSystem <| SynthesisBullet] [text "Synthesis"]
                    ]
                    , div [style "margin-left" "200px",style "margin-top" "5px",style "position" "absolute",style "font-size" "20px"][text("Tip: "++sys.tip)]
                ]
        else
            div [] []