module Display.DisplayChoosingWeapon exposing (showWeaponChoosingSystem)
import Messages exposing (Msg)
import Model exposing (Model,WeaponUnlockSys)
import Html exposing (Html, div, text, button, progress,img)
import Html.Attributes exposing (style, disabled,src,class)
import Html.Events exposing (onClick)
import Weapon exposing (Arsenal(..),defaultWeapon)

import Messages exposing (SynthesisMsg(..),Msg(..),WeaponChoosingMsg(..))

showWeaponChoosingSystem : Model -> Html Msg
showWeaponChoosingSystem model =
    if model.myself.weaponUnlockSys.active then
    let
        txt = "Hello"
        sys = model.myself.weaponUnlockSys
    in
        div
        [ style "background" "rgba(236, 240, 241, 0.89)"
        , style "color" "#34495f"
        , style "height" "400px"
        , style "left" "165px"
        -- , style "padding" "0 140px"
        , style "position" "absolute"
        , style "top" "155px"
        , style "width" "680px"
        , style "background-size" "100% 100%"
        ]
        [
          div [style "position" "absolute",style "margin-left" "290px",style "margin-top" "5px", style "color" "red",style "font-size" "25px"] [text "Unlock Weapon"]
        , div[][
            div[style "margin" "10px 0 0 120px"]
            [weaponToButton Pistol sys, weaponToButton Gatling sys, weaponToButton Mortar sys, weaponToButton Shotgun sys]
        ]
        ,div[style "margin-top" "-20px"
            , style "margin-left" "350px"]
            [ div [style "margin-left" "65px", style "margin-top" "-30px",style "font-size" "15px" ] [text ""]
            , div[ style "margin" "5px 10px 5px 10px"
            , style "height" "200px"
            , style "width" "200px"
            , style "background" "#FFF"]
            [text txt]

        ]
        , button
            [ class "btn btn-primary btn-ghost btn-shine"
            , onClick <| WeaponChoosing UnlockWeapon
            , style "margin" "80px 0 0 250px"
            , style "width" "200px"
            , style "height" "50px"
            , style "color" "black"
            , style "font-size" "20px"
            ]
            [text "Unlock"]

        ,  button
            [ class "btn btn-primary btn-ghost btn-shine"
            , onClick <| WeaponChoosing CloseWindow
            , style "margin" "20px 0 0 250px"
            , style "width" "200px"
            , style "height" "50px"
            , style "color" "black"
            , style "font-size" "20px"
            ]
            [text "Back to Game"]
        ]
    else
        div[][]

weaponToButton : Arsenal -> WeaponUnlockSys ->  Html Msg
weaponToButton weapon sys=
    let
        level =
            case weapon of
                Pistol -> 1
                Gatling -> 2
                Mortar -> 3
                Shotgun -> 4
                NoWeapon -> 0
        isChosen = weapon == sys.chosen
        --top = (String.fromInt ((level - 1) * 50)) ++ "px"
        top = "100px"
        leftAdd =
            20

        left = (String.fromInt (140 * level - 180)) ++ "px"
        color = if List.member weapon (List.map (\w -> w.extraInfo) sys.unlockedWeapons) then "1" else "0.5"
        border = if isChosen then [style "border" "1px solid purple"] else []
        name =
            case weapon of
                Pistol -> "Pistol"
                Gatling -> "Gatling"
                Mortar -> "Mortar"
                Shotgun -> "Shotgun"
                NoWeapon -> ""
    in
    Html.img
    ([ onClick <| WeaponChoosing <| ChoosingWeapon weapon
    , style "position" "absolute"
    , style "margin" (top ++ " 0 0 " ++ left)
    , src <| "./images/Gun/"++name++".png"
    , style "width" "100px"
    , style "height" "100px"
    , style "opacity" color
    ] ++ border)
    []
