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
        -- getUrl = 
    in
        Svg.image [Svg.Attributes.x <| String.fromFloat (effect.x - effect.r), 
                   Svg.Attributes.y <| String.fromFloat (effect.y - effect.r), 
                   Svg.Attributes.xlinkHref ("./images/Explosion/Ex_0"++ String.fromInt (counternow+1) ++".png"), 
                   Svg.Attributes.preserveAspectRatio "none meet", 
                   Svg.Attributes.width <| String.fromFloat (effect.r*2), 
                   Svg.Attributes.height <| String.fromFloat (effect.r*2)
                --    Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 520)")
                  ][]

showExplosion : List ExplosionEffect -> List (Svg.Svg Msg)
showExplosion  model =
    List.map explosion model