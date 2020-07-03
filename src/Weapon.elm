module Weapon exposing (Bullet,WeaponInfo,Weapon,defaultWeapon,bulletConfig)
type alias Bullet =
    { x : Float 
    , y : Float
    , r : Float
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
bulletConfig = Bullet 500 500 5 0 0 False

defaultWeapon : Weapon
defaultWeapon = Weapon defaultBulletGenerator Default "Default Weapon"

defaultBulletGenerator : WeaponInfo -> Bullet
defaultBulletGenerator _ =
    bulletConfig