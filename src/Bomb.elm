module Bomb exposing (Bomb, Bombs, placeBomb, bombTick, bombToExplosion)

import Weapon exposing (ExplosionEffect)

timeCountDown : Int
timeCountDown = 100

type alias Bombs = List Bomb

type alias Bomb = 
    { x : Float
    , y : Float
    , r : Float
    , counter : Int     -- count down from 100 to 10, explode at 10 and disappear at 0
    }

placeBomb : (Float, Float) -> Bomb
placeBomb (x, y) =
    Bomb x y 30 (timeCountDown+10)

isExplodeNow : Bomb -> Bool
isExplodeNow bomb = 
    bomb.counter == 10

bombTick : Bombs -> Bombs -> (Bombs, Bombs)
bombTick newBomb oldBomb =
    let
        next b = {b|counter = b.counter - 1}
        newWaiting = List.map next oldBomb
        (explode, stillWait) = List.partition isExplodeNow newWaiting
        finalWait = stillWait ++ newBomb
    in
        (finalWait, explode)

bombToExplosion : Bomb -> ExplosionEffect
bombToExplosion bomb =
    ExplosionEffect bomb.x bomb.y bomb.r 0