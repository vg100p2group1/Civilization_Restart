module Animation.Explosion exposing (showExplosion)

import Weapon exposing (ExplosionEffect,ExplosionType(..))
import Messages exposing (Msg(..))
import Html
import Svg 
import Svg.Attributes 

explosion : ExplosionEffect -> Svg.Svg Msg
explosion effect =
    let
        counternow = effect.counter
        
        -- d1=Debug.log "direction u r l d"    (me.moveUp&&me.moveRight&&me.moveLeft&&me.moveDown)
        getUrl =
            if effect.explosionType == BulletEffect then 
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
            else
              case counternow//3 of 
                    0 ->
                      "#Bomb1"
                    1 ->
                      "#Bomb2"  
                    2 ->
                      "#Bomb3"   
                    3 ->
                      "#Bomb4" 
                    _ ->
                      "#Bomb4"

        -- d1 = Debug.log "counter,url" (counternow,getUrl)
    in
        Svg.use [Svg.Attributes.x <| String.fromFloat (effect.x - effect.r), 
                 Svg.Attributes.y <| String.fromFloat (effect.y - effect.r), 
                 Svg.Attributes.xlinkHref getUrl
                ][]


showExplosion : List ExplosionEffect -> List (Svg.Svg Msg)
showExplosion  model =
    List.map explosion model