module Display.DisplaySkill exposing (showSkill)
import Model exposing (Model)
import Messages exposing (Msg(..), SkillMsg(..))
import Attributes exposing (Attr, AttrType(..), getCurrentAttr, getMaxAttr, getAttrName)
import Html exposing (Html, div, text, button, progress)
import Html.Attributes exposing (style, disabled,src,class)
import Html.Events exposing (onClick)
import Html.Events.Extra.Mouse as Mouse
import Svg 
import Svg.Attributes 
import Skill exposing (getCurrentSubSystem, Skill, unlockChosen,getCurrentSkillName)

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
            -- (id,level) = curr.chosen
            skillName = getCurrentSkillName curr
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
            , style "background-image" "url(images/InterfaceBg/b3.jpg)"
            , style "border-radius" "35px"
            , style "box-shadow" "20px 20px 10px #888888"
            , style "border-style" "inset"
            , style "opacity" "0.89"
            ]
            [ 
              div [ style "position" "absolute"
                  , style "margin-left" "290px"
                  , style "margin-top" "5px"
                  , style "color" "red"
                  , style "font-size" "25px"]
                  [text "Skill-Tree"]
            , div[ style "margin-top" "20px"]
                [ button
                [ class "btn btn-primary btn-ghost btn-shine"
                , style "width" "35px"
                , style "height" "35px"
                , style "color" "black"
                , onClick <| SkillChange <| SubSystemChange False
                , style "margin" "20px 0 0 87px"
                , style "float" "left"
                --, style "background" "#ff9999"
                , style "background" "linear-gradient(to right, #ffcccc, #ffcc66)"
                --, style "opacity" "0.8"
                , style "font-size" "16px"] [text "<"]
            , div [style "margin" "23px 0 0 20px", style "color" "black", style "float" "left", style "font-size" "21px"] [text sysName]
            , button
            [ class "btn btn-primary btn-ghost btn-shine"
            , style "width" "35px", style "height" "35px"
            , style "color" "black"
            , onClick <| SkillChange <| SubSystemChange True
            , style "background" "linear-gradient(to left, #ffcccc, #ffcc66)"
            , style "font-size" "16px"
            , style "margin" "20px 0 0 20px"] [text ">"]
            , div[][
                div[style "margin" "10px 0 0 120px"]
                (List.map (skillToButton curr.chosen) skills)
            ]]
            ,div[style "margin-top" "-20px"
                , style "margin-left" "350px"]
                [ div [style "margin-left" "-110px", style "text-align" "center",style "font-size" "20px", style "font-weight" "bold" ] [text  skillName]
                , div [style "margin-left" "45px", style "margin-top" "15px",style "font-size" "18px", style "font-weight" "bold"] [text <| "Points Left: "++ points]
                , div[ style "margin" "25px 10px 10px 10px"
                , style "height" "150px"
                , style "width" "200px"
                --, style "background" "#FFF"]
                --, style "opacity" "0.1"]
                , style "font-weight" "bold"
                , style "color" "black"
                ]
                [text txt]
            
            ]
            , button
                [ class "btn btn-primary btn-ghost btn-shine"
                , onClick <| SkillChange <| UnlockSkill
                , style "margin" "20px 0 0 250px"
                , disabled (not chosenCanUnlock)
                , style "width" "200px"
                , style "height" "50px"
                , style "color" "black"
                , style "font-size" "20px"
                , style "background" "linear-gradient(to left, #ffcccc, #ffcc66)"
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
        top = (String.fromInt ((level-1) * 62)) ++ "px"

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
    , style "width" "62px"
    , style "height" "62px"
    , style "opacity" color
    ] ++ border)
    []


-- getUrl