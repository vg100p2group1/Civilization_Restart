
module Weapon exposing (Bullet,WeaponInfo,Weapon,defaultWeapon,ShooterType(..),bulletConfig,weaponList,generateBullet,Arsenal(..),ExplosionEffect,bulletToExplosion)

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
    , period : Float
    , maxPeriod : Float
    , image : String
    , counter : Float
    , hasFired : Bool
    , level : Int 
    }

bulletConfig : Bullet
bulletConfig = Bullet 500 500 5 (Circle 500 500 5) 0 0 False Player 20

defaultWeapon : Weapon
defaultWeapon =
    { bulletGenerator = defaultBulletGenerator
    , extraInfo = Pistol
    , name  = "Pistol"
    -- newly added
    , number = 1
    , color = "green"
    , bulletNumber = 0
    , auto = False
    , period = 50
    , maxPeriod = 50
    , image = ""
    , counter = 1
    , hasFired = False
    , level = 1
    }

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
                    {bulletConfig|force=30* toFloat weapon.level}
                Mortar ->
                    {bulletConfig|force=100* toFloat weapon.level,r=5}
                Shotgun ->
                    {bulletConfig|force=45* toFloat weapon.level,r=5}
    in
        bullet

weaponList : List Weapon
weaponList =
    let
        pistol = defaultWeapon
        gatling = Weapon defaultBulletGenerator Gatling "Gatling" 2 "orange" 0 True 5 5 "" 1 False 1
        mortar = Weapon defaultBulletGenerator Mortar "Mortar" 3 "blue" 0 False 15 15 "" 1 False 1
        shotgun = Weapon defaultBulletGenerator Shotgun "Shotgun" 4 "white" 0 False 10 10 "" 1 False 1
    in

        [pistol, gatling, mortar, shotgun]

type alias ExplosionEffect =
    {
        x : Float,
        y : Float,
        r : Float,
        counter : Int
    }

bulletToExplosion : Bullet -> ExplosionEffect 
bulletToExplosion model = 
    ExplosionEffect model.x model.y (model.r*2) 0