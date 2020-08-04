module Display.DisplayChoosingWeapon exposing (showWeaponChoosingSystem)
import Messages exposing (Msg)
import Model exposing (Model,WeaponUnlockSys)
import Html exposing (Html, div, text, button, progress,img)
import Html.Attributes exposing (style, disabled,src,class)
import Html.Events exposing (onClick)
import Weapon exposing (Arsenal(..),defaultWeapon)
import Markdown exposing (toHtml)
import Messages exposing (SynthesisMsg(..),Msg(..),WeaponChoosingMsg(..))

showWeaponChoosingSystem : Model -> Html Msg
showWeaponChoosingSystem model =
    if model.myself.weaponUnlockSys.active then
    let
        getName = case model.myself.weaponUnlockSys.chosen of
            Pistol ->
                "Gauß Revolver"
            Gatling ->
                "HexTech Ripper"
            Shotgun ->
                "Meteor Shotgun"
            Mortar ->
                "Doomsday Rifle"
            _ ->
                "Nothing"

        sys = model.myself.weaponUnlockSys
    in
        div
        [ style "background" "rgba(236, 240, 241, 0.89)"
        , style "color" "#34495f"
        , style "height" "400px"
        , style "left" "165px"
        -- , style "padding" "0 140px"
        , style "position" "absolute"
        , style "top" "250px"
        , style "width" "680px"
        , style "background-size" "100% 100%"
        , style "border-radius" "35px"
        , style "box-shadow" "20px 20px 10px #888888"
        , style "border-style" "inset"
        , style "background-image" "url(images/InterfaceBg/b1.jpg)"
        , style "opacity" "0.89"
        ]
        [
          div [ style "position" "absolute"
              , style "margin-left" "200px"
              , style "margin-top" "5px"
              , style "font-family" ""
              , style "font-family" "lucida sans unicode,lucida grande, sans-serif"
              , style "text-shadow" "5px 5px 5px black"
              , style "color" "black",style "font-size" "25px"]
              [text "Weapon Unlocking System"]
        , div[][
            div[style "margin" "0 0 0 120px"]
            [weaponToButton Pistol sys, weaponToButton Gatling sys, weaponToButton Mortar sys, weaponToButton Shotgun sys]
        ]
        ,div[style "margin-top" "165px"
            , style "margin-left" "100px"]
            [ div [style "margin-left" "210px", style "margin-top" "0", style "font-size" "25px", style "font-weight" "bold"] [text "Tips"]
            , div [style "margin-left" "155px", style "margin-top" "0", style "font-size" "20px", style "font-weight" "bold"] [text getName]
            , div[ style "margin" "-5px 10px 5px -50px"
            , style "height" "100px"
            , style "width" "600px"
            , style "background" "rgba(236, 240, 241, 0.89)"]
            [case model.myself.weaponUnlockSys.chosen of
                Pistol -> Markdown.toHtml [] """
* Simple science and technology product
* One of standard arms in the military
* Use little amount of bullet
* Low ATK and low shooting speed
"""
                Gatling ->
                    Markdown.toHtml [] """
* A machine gun with fast rate of fire and huge damage
* It used to be called "Death sickle"
* In the past, three soldiers were need to to move this big guy
* With exoskeleton armor, a well trained warrior can easily use it
"""
                Shotgun ->
                    Markdown.toHtml [] """
* Manufactured by the biggest gun producer in the M&M empire
* It was the most popular weapon before "the end day"
* Use three bullets every shot
* Can make huge damage in short distance
"""
                _ ->
                    Markdown.toHtml [] """
* The most accurate and powerful rifle gun ever made
* Rather than a gun, some people prefer to call it a cannon
* The main purpose of the gun was to destroy vehicles like helicopters
* Now it becomes the best weapon to deal with huge robot monsters
"""
            ]

        ]
        , div[style "position" "absolute"]
        [
          button
            [ class "btn btn-primary btn-ghost btn-shine"
            , onClick <| WeaponChoosing UnlockWeapon
            , style "margin" "0 0 0 250px"
            , style "width" "200px"
            , style "height" "50px"
            , style "color" "black"
            , style "font-size" "20px"
            , style "background" "linear-gradient(to right, #6699ff, #99cc99)"
            --, style "float" "left"
            ]
            [text "Unlock"]
        {-
        ,
          button
            [ class "btn btn-primary btn-ghost btn-shine"
            , onClick <| WeaponChoosing CloseWindow
            , style "margin" "-100px 0 0 380px"
            , style "width" "200px"
            , style "height" "50px"
            , style "color" "black"
            , style "font-size" "20px"
            --, style "float" "left"
            ]
            [text "Back to Game"]
        -}
        ]
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
        top = "60px"
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
