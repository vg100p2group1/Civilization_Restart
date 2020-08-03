module Control.ExplosionControl exposing (updateExplosion,explosionToViewbox)
import Model exposing (Me)
import Config exposing (viewBoxMax)
import Weapon exposing (ExplosionEffect,Bullet,bulletToExplosion,ExplosionType(..))
import Bomb exposing (Bombs, bombToExplosion)

updateExplosion : List ExplosionEffect -> List Bullet -> Bombs -> List ExplosionEffect
updateExplosion originalExplosion filteredBullet explodeBomb=
    let
        filterFunction model=
            (model.counter<2 && model.explosionType == BulletEffect) || ((model.counter//3)<4 && model.explosionType == BombEffect) 
        filteredExplosion = List.filter (\value -> filterFunction value) originalExplosion
        updatedExplosion = List.map (\value->{value|counter=value.counter+1}) filteredExplosion
    in
        updatedExplosion ++  List.map bulletToExplosion filteredBullet ++ List.map bombToExplosion explodeBomb


explosionToViewbox : Me -> List ExplosionEffect -> List ExplosionEffect
explosionToViewbox me explosion=
    List.map (\value->{ value | x=viewBoxMax/2+value.x-me.x,y=viewBoxMax/2 +value.y-me.y}) explosion    
