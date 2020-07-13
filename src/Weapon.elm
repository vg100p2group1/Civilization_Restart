module Weapon exposing (Bullet,WeaponInfo,Weapon,defaultWeapon,fireBullet,updateBullet,ShooterType(..))

import Shape exposing (Circle, recCollisionTest,circleRecTest,circleCollisonTest)
import Config exposing (bulletSpeed)
import Map.Map exposing (Map)

type alias Bullet =
    { x : Float
    , y : Float
    , r : Float
    , hitbox : Circle
    , speedX : Float
    , speedY : Float
    , collision : Bool
    , from : ShooterType
    , force : Float
    }
type ShooterType
    = Player
    | Monster

type WeaponInfo 
    = Default

type alias Weapon = 
    { bulletGenerator :  WeaponInfo -> Bullet
    , extraInfo : WeaponInfo
    , name : String
    }

bulletConfig : Bullet
bulletConfig = Bullet 500 500 5 (Circle 500 500 5) 0 0 False Player 20

defaultWeapon : Weapon
defaultWeapon = Weapon defaultBulletGenerator Default "Default Weapon"

defaultBulletGenerator : WeaponInfo -> Bullet
defaultBulletGenerator _ =
    bulletConfig

fireBullet : (Float, Float) -> (Float, Float) -> Bullet
fireBullet (mouseX,mouseY) (meX, meY) =
    let
        posX = mouseX
        posY = mouseY
        unitV = sqrt ((posX - 500) * (posX - 500) + (posY - 500) * (posY - 500)) 
        xTemp = bulletSpeed / unitV * (posX - 500)
        yTemp = bulletSpeed / unitV * (posY - 500)
        newCircle = Circle meX meY 5
    in
        {bulletConfig | hitbox = newCircle, speedX=xTemp, speedY=yTemp}

updateBullet : Map -> List Bullet -> List Bullet
updateBullet map bullets =
    let
        updateXY b =
            let
                newX = b.hitbox.cx + b.speedX
                newY = b.hitbox.cy + b.speedY
                newHitbox = Circle newX newY b.hitbox.r
            in
                {b|hitbox = newHitbox,x=newX, y=newY}

        allBullets = bullets
                    |> List.filter (\b -> not (List.any (circleRecTest b.hitbox) (List.map .edge map.walls)))
                    |> List.filter (\b -> not (List.any (circleRecTest b.hitbox) (List.map .edge map.obstacles)))
                    |> List.filter (\b -> not (List.any (circleRecTest b.hitbox) (List.map .edge map.doors)))
                    |> List.filter (\b -> not (List.any (circleCollisonTest b.hitbox) (List.map .position map.monsters)))
        finalBullets = List.map updateXY allBullets
    in
        finalBullets

