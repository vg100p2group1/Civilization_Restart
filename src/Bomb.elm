module Bomb exposing (Bomb, Bombs, makeBomb, bombTick, bombToExplosion, bombToHitbox)

import Weapon exposing (ExplosionEffect,ExplosionType(..))
import Shape exposing (Circle)

timeCountDown : Int
timeCountDown = 100

type alias Bombs = List Bomb

type alias Bomb = 
    { x : Float
    , y : Float
    , r : Float
    , counter : Int     -- count down from 100 to 10, explode at 10 and disappear at 0
    }

makeBomb : (Float, Float) -> Bomb
makeBomb (x, y) =
    Bomb x y 100 (timeCountDown+10)

isExplodeNow : Bomb -> Bool
isExplodeNow bomb = 
    bomb.counter == 10

bombTick : Bombs -> (Bombs, Bombs)
bombTick bombs =
    let
        next b = {b|counter = b.counter - 1}
        newWaiting = List.map next bombs
        (explode, stillWait) = List.partition isExplodeNow newWaiting
    in
        (stillWait, explode)

bombToExplosion : Bomb -> ExplosionEffect
bombToExplosion bomb =
    ExplosionEffect bomb.x bomb.y bomb.r 0 BombEffect

bombToHitbox : Bomb -> Circle
bombToHitbox bomb =
    Circle bomb.x bomb.y bomb.r