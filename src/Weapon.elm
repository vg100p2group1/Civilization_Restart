module Weapon exposing (Bullet,WeaponInfo,Weapon,defaultWeapon,ShooterType(..),bulletConfig)

import Shape exposing (Circle)
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
bulletConfig = Bullet 500 500 5 (Circle 500 500 5) 0 0 False Player 50

defaultWeapon : Weapon
defaultWeapon = Weapon defaultBulletGenerator Default "Default Weapon"

defaultBulletGenerator : WeaponInfo -> Bullet
defaultBulletGenerator _ =
    bulletConfig

