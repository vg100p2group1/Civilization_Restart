
module Model exposing (Me,Model,State(..), Dialogues, Sentence, Side(..), Role(..), AnimationState)
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
    , state : State
    , currentDialogues: Dialogues
    }

type State = Dialogue
           | Others

type Side = Left
          | Right
          | Bottom

type Role = Monster
          | Player
          | Narrative

type alias Sentence =
    { text: String
    , side: Side
    , role: Role
    , auto: Bool
    , speed: Float
    , image: String
    }

type alias Dialogues = List Sentence

type alias AnimationState =
    Maybe
    { active: Bool
    , elapsed: Float
    }