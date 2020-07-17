module Weapon exposing (Bullet,WeaponInfo,Weapon,defaultWeapon,ShooterType(..),bulletConfig,weaponList,generateBullet,Arsenal(..))

import Shape exposing (Circle)

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

type Arsenal
    = Pistol
    | Gatling
    | Mortar
    | Shotgun

type alias Weapon = 
    { bulletGenerator : WeaponInfo -> Bullet
    , extraInfo : Arsenal
    , name : String
    -- newly added
    , number : Int
    , color : String
    , bulletNumber : Int
    , auto : Bool
    , frequency : Float
    , image : String
    }

bulletConfig : Bullet
bulletConfig = Bullet 500 500 5 (Circle 500 500 5) 0 0 False Player 20

defaultWeapon : Weapon
defaultWeapon = Weapon defaultBulletGenerator Pistol "Pistol" 1 "green" 0 False 0 ""

defaultBulletGenerator : WeaponInfo -> Bullet
defaultBulletGenerator _ =
    bulletConfig

generateBullet : Weapon -> Bullet
generateBullet weapon =
    let
        bullet =
            case weapon.extraInfo of
                Pistol ->
                    bulletConfig
                Gatling ->
                    {bulletConfig|force=30}
                Mortar ->
                    {bulletConfig|force=100,r=15}
                Shotgun ->
                    {bulletConfig|force=45,r=10}
    in
        bullet

weaponList : List Weapon
weaponList =
    let
        pistol = defaultWeapon
        gatling = Weapon defaultBulletGenerator Gatling "Gatling" 2 "red" 0 True 0 ""
        mortar = Weapon defaultBulletGenerator Mortar "Mortar" 3 "blue" 0 False 0 ""
        shotgun = Weapon defaultBulletGenerator Shotgun "Shotgun" 4 "white" 0 False 0 ""
    in
        [pistol, gatling, mortar, shotgun]