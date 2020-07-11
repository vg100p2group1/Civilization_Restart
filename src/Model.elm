module Model exposing (Me,Model)
import Random
import Map.Map exposing(Room,Map)
import Shape exposing (Circle)
import Weapon exposing (Bullet,Weapon)

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

type alias Model =
    { 
      myself :  Me    
    , bullet : List Bullet 
    , bulletViewbox : List Bullet
    , map : Map
    , rooms : (List Room,Random.Seed)
    , viewbox : Map
    , size : (Float,Float)
    }