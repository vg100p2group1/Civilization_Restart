module Model exposing (Me,Model,defaultMe)
import Random
import Map.Map exposing(Room,Map)
import Shape exposing (Circle)
import Weapon exposing (Bullet,Weapon)
import Config exposing (playerSpeed)

type alias Me =
    { x : Float
    , y : Float
    , r : Float
    , xSpeed : Float
    , ySpeed : Float
    , rotate : Float
    , moveUp : Bool
    , moveRight : Bool
    , moveLeft : Bool
    , moveDown : Bool
    , mouseData : (Float,Float)
    , fire : Bool -- 到时候用sum type
  --   , name : String
  --   , score : Float
    , hitBox : Circle
    , weapons : List Weapon     -- the first element is the one in use
    }

defaultMe : Me
defaultMe = Me 0 0 50 playerSpeed 0 0 False False False False (500,500) False (Circle 0 0 50) []

type alias Model =
    { myself : Me
    , bullet : List Bullet 
    , bulletViewbox : List Bullet
    , map : Map
    , rooms : (List Room,Random.Seed)
    , viewbox : Map
    }