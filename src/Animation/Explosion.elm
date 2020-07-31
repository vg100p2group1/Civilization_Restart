module Animation.Explosion exposing (showExplosion)

import Weapon exposing (ExplosionEffect)
import Messages exposing (Msg(..))

import Svg 
import Svg.Attributes 

explosion : ExplosionEffect -> Svg.Svg Msg
explosion effect =
    let
        counternow = effect.counter
        
        -- d1=Debug.log "direction u r l d"    (me.moveUp&&me.moveRight&&me.moveLeft&&me.moveDown)
        getUrl =
            case counternow of 
                0 ->
                  -- "./images/Explosion/Ex_01.png"
                  "#Ex1"
                1 ->
                  "#Ex2"  
                2 ->
                  "#Ex2"   
                3 ->
                  "#Ex2" 
                _ ->
                  "#Ex2"
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
        Svg.use [Svg.Attributes.x <| String.fromFloat (effect.x - effect.r), 
                 Svg.Attributes.y <| String.fromFloat (effect.y - effect.r), 
                 Svg.Attributes.xlinkHref getUrl
                --  Svg.Attributes.width <| String.fromFloat (effect.r*2), 
                --  Svg.Attributes.height <| String.fromFloat (effect.r*2)
                --    Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 520)")
                ][]

showExplosion : List ExplosionEffect -> List (Svg.Svg Msg)
showExplosion  model =
    List.map explosion model