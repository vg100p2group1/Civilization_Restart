module Control.ExplosionControl exposing (updateExplosion,explosionToViewbox)
import Model exposing (Me)
import Config exposing (viewBoxMax)
import Weapon exposing (ExplosionEffect,Bullet,bulletToExplosion)
import Bomb exposing (Bombs, bombToExplosion)

updateExplosion : List ExplosionEffect -> List Bullet -> Bombs -> List ExplosionEffect
updateExplosion originalExplosion filteredBullet explodeBomb=
    let
        filteredExplosion = List.filter (\value -> value.counter<2) originalExplosion
        updatedExplosion = List.map (\value->{value|counter=value.counter+1}) filteredExplosion
    in
        updatedExplosion ++  List.map bulletToExplosion filteredBullet ++ List.map bombToExplosion explodeBomb


explosionToViewbox : Me -> List ExplosionEffect -> List ExplosionEffect
explosionToViewbox me explosion=
    List.map (\value->{ value | x=viewBoxMax/2+value.x-me.x,y=viewBoxMax/2 +value.y-me.y}) explosion    
