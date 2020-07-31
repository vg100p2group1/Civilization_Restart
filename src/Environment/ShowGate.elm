module Environment.ShowGate exposing (showGate)
import Map.Map exposing (Gate)
import Messages exposing (Msg(..))

import Svg 
import Svg.Attributes 

showGate : Gate -> Svg.Svg Msg
showGate gate =
    let
        counternow = modBy 15 (gate.counter//5) 
        
        -- d1=Debug.log "direction u r l d"    (me.moveUp&&me.moveRight&&me.moveLeft&&me.moveDown)
        getUrl =
            "#Gate"++ String.fromInt counternow
        -- d1 = Debug.log "counter,url" (counternow,getUrl)
    in
        -- Svg.image [Svg.Attributes.x <| String.fromFloat (effect.x - effect.r), 
        --            Svg.Attributes.y <| String.fromFloat (effect.y - effect.r), 
        --            Svg.Attributes.xlinkHref getUrl, 
        --            Svg.Attributes.preserveAspectRatio "none meet", 
        --            Svg.Attributes.width <| String.fromFloat (effect.r*2), 
        --            Svg.Attributes.height <| String.fromFloat (effect.r*2)
        --         --    Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 520)")
        --           ][]
        if gate.canShow then 
            Svg.use [Svg.Attributes.x <| String.fromFloat gate.position.x, 
                 Svg.Attributes.y <| String.fromFloat gate.position.y, 
                 Svg.Attributes.xlinkHref getUrl
                ][]
        else
            Svg.rect[][]