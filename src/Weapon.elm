module Weapon exposing (Bullet,WeaponInfo,Weapon,defaultWeapon,fireBullet,updateBullet)

import Shape exposing (Circle)
import Config exposing (bulletSpeed)

type alias Bullet =
    { hitbox : Circle
    , speedX : Float
    , speedY : Float
    , collision : Bool
    }

type WeaponInfo 
    = Default

type alias Weapon = 
    { bulletGenerator :  WeaponInfo -> Bullet
    , extraInfo : WeaponInfo
    , name : String
    }

bulletConfig : Bullet
bulletConfig = Bullet (Circle 500 500 5) 0 0 False

defaultWeapon : Weapon
defaultWeapon = Weapon defaultBulletGenerator Default "Default Weapon"

defaultBulletGenerator : WeaponInfo -> Bullet
defaultBulletGenerator _ =
    bulletConfig

fireBullet : (Float, Float) -> Bullet
fireBullet (mouseX,mouseY)=
    let
        posX = mouseX
        posY = mouseY
        unitV = sqrt ((posX - 500) * (posX - 500) + (posY - 500) * (posY - 500)) 
        xTemp = bulletSpeed / unitV * (posX - 500)
        yTemp = bulletSpeed / unitV * (posY - 500)
    in
        {bulletConfig | x=me.x,y=me.y,speedX=xTemp,speedY=yTemp}

updateBullet : List Bullet -> List Bullet
updateBullet bullets =
    let
        updateXY model =
            let
                newX = model.x + model.speedX
                newY = model.y + model.speedY
            in
                {model|x=newX,y=newY}
            -- Remove all bullets that hit the wall/ the door.
    in
        List.map updateXY bullets