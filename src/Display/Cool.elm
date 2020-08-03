module Display.Cool exposing (showSkillCooling)
import Html exposing (div, img)
import Html.Attributes exposing (style, src, width, height)

import Model exposing (Model)
import Messages exposing (Msg)
import Skill exposing (..)


showSkillCooling : Model -> Float -> Html.Html Msg
showSkillCooling model r=
    let
        me=model.myself
        dualWield = me.dualWield
        margin k =
             String.fromFloat (k*60*r) ++ "px"
        marginTop =
             String.fromFloat (-54*r) ++ "px"
    in
        div[][
            div[][showDualWield model dualWield r],
            div[style "position" "absolute", style "margin-top" marginTop, style "margin-left" <| margin 1][showFlash model me.flash r],
            div[style "position" "absolute", style "margin-top" marginTop, style "margin-left" <| margin 2][showAT model me.absoluteTerrifyField r],
            div[style "position" "absolute", style "margin-top" marginTop, style "margin-left" <| margin 3][showInvisible model me.invisible r],
            div[style "position" "absolute", style "margin-top" marginTop, style "margin-left" <| margin 4][showBlast model me.directionalBlasting r]
        ]

showDualWield : Model->Int -> Float -> Html.Html Msg 
showDualWield model num r=
    let
        maxNum = 100.0
        current = 
            if num<0 then
                maxNum - toFloat (abs num)
            else 
                maxNum
        heightNow = 
            -- if 50-(50*current/maxNum*r) <0 then
            --     0
            -- else 
                50*r-(50*current/maxNum*r)
        dual = skillState 2 1 4 model.myself.skillSys.subsys subSysBerserker skillDualWield 
    in
        if dual then 
            div[][img[src "./images/Cool/Dual Wield.png",width <| round ( 50*r), height  <| round (50*r)][], 
                div[style "position" "absolute", style "margin-top" ((String.fromFloat <|  (-55.5*r))++"px"), style  "width"  ((String.fromInt <| round ( toFloat 50*r))++"px"), style "height"  ((String.fromFloat <| heightNow) ++"px"), style "background-color" "rgba(0,0,0,0.5)"][]
                ]
        else
            div[][img[src "./images/Cool/Lock1.png",width <| round ( 50*r), height  <| round (50*r)][]]
    

showFlash : Model -> Int -> Float -> Html.Html Msg 
showFlash model  num r=
    let
        maxNum = 100.0
        current = 
            if num<0 then
                maxNum - toFloat (abs num)
            else 
                maxNum
        heightNow = 
                50*r-(50*current/maxNum*r)
        flash = skillState 0 0 4 model.myself.skillSys.subsys subSysPhantom skillFlash
    in
        if flash then 
            div[][img[src "./images/Cool/Space Jump.png",width <| round ( 50*r), height  <| round (50*r)][], 
                div[style "position" "absolute", style "margin-top" ((String.fromFloat <|  (-55.5*r))++"px"), style  "width"  ((String.fromInt <| round ( toFloat 50*r))++"px"), style "height"  ((String.fromFloat <| heightNow) ++"px"), style "background-color" "rgba(0,0,0,0.5)"][]
                ]
        else
            div[][img[src "./images/Cool/Lock2.png",width <| round ( 50*r), height  <| round (50*r)][]]

showAT : Model->Int -> Float -> Html.Html Msg 
showAT model num r=
    let
        maxNum = 100.0
        current = 
            if num<0 then
                maxNum - toFloat (abs num)
            else 
                maxNum
        heightNow = 
                50*r-(50*current/maxNum*r)
        aT = skillState 1 0 4 model.myself.skillSys.subsys subSysMechanic skillAbsoluteTerritoryField
    in
        if aT then 
            div[][img[src "./images/Cool/AT.png",width <| round ( 50*r), height  <| round (50*r)][], 
                div[style "position" "absolute", style "margin-top" ((String.fromFloat <|  (-55.5*r))++"px"), style  "width"  ((String.fromInt <| round ( toFloat 50*r))++"px"), style "height"  ((String.fromFloat <| heightNow) ++"px"), style "background-color" "rgba(0,0,0,0.5)"][]
                ]
        else
            div[][img[src "./images/Cool/Lock3.png",width <| round ( 50*r), height  <| round (50*r)][]]

showInvisible : Model->Int -> Float -> Html.Html Msg 
showInvisible model num r=
    let
        maxNum = 100.0
        current = 
            if num<0 then
                maxNum - toFloat (abs num)
            else 
                maxNum
        heightNow = 
                50*r-(50*current/maxNum*r)
        invisible = skillState 0 1 4 model.myself.skillSys.subsys subSysPhantom skillInvisible
    in
        if invisible then 
            div[][img[src "./images/Cool/Invisible.png",width <| round ( 50*r), height  <| round (50*r)][], 
                div[style "position" "absolute", style "margin-top" ((String.fromFloat <|  (-55.5*r))++"px"), style  "width"  ((String.fromInt <| round ( toFloat 50*r))++"px"), style "height"  ((String.fromFloat <| heightNow) ++"px"), style "background-color" "rgba(0,0,0,0.5)"][]
                ]
        else 
            div[][img[src "./images/Cool/Lock4.png",width <| round ( 50*r), height  <| round (50*r)][]]

showBlast : Model -> Int -> Float -> Html.Html Msg 
showBlast model num r=
    let
        maxNum = 1200.0
        current = 
            if num<0 then
                maxNum - toFloat (abs num)
            else 
                maxNum
        heightNow = 
                50*r-(50*current/maxNum*r)
        blast = Skill.skillState 1 1 3 model.myself.skillSys.subsys subSysMechanic skillDirectionalBlasting
    in
        if blast then
            div[][img[src "./images/Cool/Blast.png",width <| round ( 50*r), height  <| round (50*r)][], 
                div[style "position" "absolute", style "margin-top" ((String.fromFloat <|  (-55.5*r))++"px"), style  "width"  ((String.fromInt <| round ( toFloat 50*r))++"px"), style "height"  ((String.fromFloat <| heightNow) ++"px"), style "background-color" "rgba(0,0,0,0.5)"][]
                ]
        else
            div[][img[src "./images/Cool/Lock5.png",width <| round ( 50*r), height  <| round (50*r)][]]