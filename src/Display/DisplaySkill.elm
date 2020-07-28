module Display.DisplaySkill exposing (showSkill)
import Model exposing (Model)
import Messages exposing (Msg(..), SkillMsg(..))
import Attributes exposing (Attr, AttrType(..), getCurrentAttr, getMaxAttr, getAttrName)
import Html exposing (Html, div, text, button, progress)
import Html.Attributes exposing (style, disabled,src)
import Html.Events exposing (onClick)
import Html.Events.Extra.Mouse as Mouse
import Svg 
import Svg.Attributes 
import Skill exposing (getCurrentSubSystem, Skill, unlockChosen)

showSkill : Model -> Html Msg
showSkill model =
    let
        sys = model.myself.skillSys
    in
    if sys.active then
        let
            curr = getCurrentSubSystem sys
            skills = curr.skills
            points = String.fromInt sys.points
            txt = curr.text
            sysName = curr.name
            currentCost = (Tuple.second (unlockChosen curr))
            chosenCanUnlock = currentCost > 0 && currentCost <= sys.points 
        in
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
            [ button [onClick <| SkillChange <| SubSystemChange False, style "margin" "20px 0 0 100px",style "float" "left"] [text "<"]
            , div [style "margin" "20px 0 0 20px", style "color" "red", style "float" "left"] [text sysName]
            , button [onClick <| SkillChange <| SubSystemChange True,style "margin" "20px 0 0 20px"] [text ">"]
            , div [style "margin" "20px 0 0 180px"] [text points]
            , div
                [style "margin" "20px 0 0 120px"]
                (List.map (skillToButton curr.chosen) skills)
            , div
                [ style "margin" "230px 0 0 0"
                , style "padding" "5px 10px 5px 10px"
                , style "height" "60px"
                , style "background" "#FFF"]
                [text txt]
            , button
                [ onClick <| SkillChange <| UnlockSkill
                , style "margin" "20px 0 0 180px"
                , disabled (not chosenCanUnlock)
                ]
                [text "Unlock"]
            ]
    else
        div [] []



skillToButton : (Int, Int) -> Skill -> Html Msg
skillToButton (chosenId, chosenLevel) skill =
    let
        id = skill.id
        level = skill.level
        isChosen = id == chosenId && level == chosenLevel
        top = (String.fromInt ((level-1) * 50)) ++ "px"

        leftAdd =
            if level == 1 || level == 2 then 
                40
            else 
                0

        left = (String.fromInt (id * 80 + leftAdd)) ++ "px"
        color = if skill.unlocked then "1" else "0.5"
        border = if isChosen then [style "border" "1px solid purple"] else []
    in
    Html.img
    ([ onClick <| SkillChange <| ChooseSkill skill.id skill.level
    , style "position" "absolute"
    , style "margin" (top ++ " 0 0 " ++ left)
    , src <| "./images/Skill/"++skill.name++".png"
    , style "width" "50px"
    , style "height" "50px"
    , style "opacity" color
    ] ++ border)
    []


-- getUrl