module Animation.SkillEffect exposing (showSkillEffect,showBackEffect)
import Model exposing (Model,Me)
import Bomb exposing (Bomb)
import Svg 
import Svg.Attributes 
import Messages exposing (Msg(..))
import Skill exposing (skillState,subSysBerserker,skillBattleFervor)
showSkillEffect : Model -> List ( Svg.Svg Msg) 
showSkillEffect model =
        [showAT model.myself,showInvisible model.myself,showFervor model]

showBackEffect : Model -> List (Svg.Svg Msg)
showBackEffect model =
    showBombs model.myself model.bomb ++ [showDual model.myself]

showBombs : Me -> List Bomb -> List (Svg.Svg Msg)
showBombs me model =
    let
        createFormate effect =
             Svg.use [Svg.Attributes.x <| String.fromFloat (1000/2+effect.x-me.x-effect.r/4), 
                 Svg.Attributes.y <| String.fromFloat (1000/2+effect.y-me.y- effect.r/4), 
                 Svg.Attributes.xlinkHref "#Bomb"
                ][]
    in
        List.map (\value->createFormate value) model

showAT : Me -> (Svg.Svg Msg)
showAT me =
    if me.absoluteTerrifyField > 0 then 
        Svg.use [Svg.Attributes.x <| String.fromFloat 400, 
                 Svg.Attributes.y <| String.fromFloat 400, 
                 Svg.Attributes.xlinkHref "#AT"
                ][]
    else 
        Svg.rect[Svg.Attributes.width "0", Svg.Attributes.height "0"][]

showDual : Me -> (Svg.Svg Msg)
showDual me =
    if me.dualWield > 0 then 
        Svg.use [Svg.Attributes.x <| String.fromFloat 475, 
                 Svg.Attributes.y <| String.fromFloat 465, 
                 Svg.Attributes.xlinkHref "#Flame"
                ][]
    else 
        Svg.rect[Svg.Attributes.width "0", Svg.Attributes.height "0"][]

showInvisible : Me -> (Svg.Svg Msg)
showInvisible me =
    if me.invisible > 0 then 
        Svg.use [Svg.Attributes.x <| String.fromFloat 450, 
                 Svg.Attributes.y <| String.fromFloat 450, 
                 Svg.Attributes.xlinkHref "#Invisible"
                ][]
    else 
        Svg.rect[Svg.Attributes.width "0", Svg.Attributes.height "0"][]

showFervor : Model -> (Svg.Svg Msg)
showFervor model =
    let
        unlock=skillState 2 0 4 model.myself.skillSys.subsys subSysBerserker skillBattleFervor
        me=model.myself
        counternow = me.counter
        framesAll = counternow//8
        frameNow = modBy 5 framesAll 
        getUrl = 
            case frameNow of
               0->
                "#Fervor1"
               1->
                "#Fervor2"
               2->
                "#Fervor3"
               3->
                "#Fervor4"
               _->
                "#Fervor5"
    in
        if unlock then 
            Svg.use [Svg.Attributes.x <| String.fromFloat 475, 
                 Svg.Attributes.y <| String.fromFloat 505, 
                 Svg.Attributes.xlinkHref getUrl
                ][]
        else 
            Svg.rect[Svg.Attributes.width "0", Svg.Attributes.height "0"][]