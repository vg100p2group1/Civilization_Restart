module Display.DisplayMonsterHp exposing (showMonsterHp)
import Messages exposing (Msg)
import Model exposing (Model,WeaponUnlockSys,State(..))
import Html exposing (Html, div, text, button, progress,img)
import Map.Map exposing (Monster)
import Model exposing (Me)
import Html.Attributes exposing (style, disabled,src,class)
import Config exposing (viewBoxMax)
showHp: Me -> Monster -> Html Msg
showHp me monster =
    let
        cx = Debug.log "cx" (monster.position.cx)
        cy = Debug.log "cy" (monster.position.cy)
        r = Debug.log "r" (monster.position.r)
        x = -me.x + viewBoxMax/2 + cx
        y = -me.y + viewBoxMax/2 + cy
        left = String.fromFloat(x - 2 * r - 10) ++ "px"
        top = String.fromFloat(y - 2 * r) ++ "px"
    in
    if x>= 0 && x <= 1000 && y >= 0 && y <= 1000 then
        div
        [
        --  style "background" "rgba(236, 240, 241, 0.89)"
        --  style "background" "white"
          style "height" "20px"
        --, style "left" "360px"
        , style "left" left
        , style "position" "absolute"
        --, style "top" "300px"
        , style "top" top
        , style "width" "20px"
        , style "background-size" "100% 100%"
        ]
        [ progress
         [ style "width" "100px"
         , style "border-radius" "35px"
         , style "opacity" "0.8"
         , style "-moz-border-radius" "35px"
         , style "-webkit-border-radius" "35px"
        , Html.Attributes.max (String.fromFloat monster.monsterType.maxhp)
        , Html.Attributes.value (String.fromFloat monster.monsterType.hp)
        {-, style "background-image" "-webkit-gradient(linear, left bottom, left top, color-stop(0, #b6bcc6), color-stop(1, #9da5b0))"
        , style "background-image" "-moz-linear-gradient(#9da5b0 0%, #b6bcc6 100%)"
        , style "-webkit-box-shadow" "inset 0px 1px 2px 0px rgba(0, 0, 0, 0.5), 0px 1px 0px 0px #FFF"
        , style "-moz-box-shadow" "inset 0px 1px 2px 0px rgba(0, 0, 0, 0.5), 0px 1px 0px 0px #FFF"
        , style "box-shadow" "inset 0px 1px 2px 0px rgba(0, 0, 0, 0.5), 0px 1px 0px 0px"
        -}
        , style "height" "10px"
        ]
        []
        ]
    else
        div[][]


showMonsterHp : Me -> List Monster -> List (Html Msg)
showMonsterHp me monsters =
    List.map (showHp me) monsters