
module Model exposing (Me,Model,State(..), Dialogues, Sentence, Side(..), Role(..), AnimationState, defaultMe, sentenceInit,mapToViewBox)
import Random
import Map.Map exposing(Room,Map)
import Shape exposing (Circle)
import Weapon exposing (Bullet,Weapon,weaponList,defaultWeapon)
import Config exposing (playerSpeed,viewBoxMax)

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
    , weapons : List Weapon     -- the first element is the one in uses
    , currentWeapon : Weapon
    }

defaultMe : Me
defaultMe = Me 500 500 50 playerSpeed 0 0 False False False False (500,500) False (Circle 500 500 50) weaponList defaultWeapon

type alias Model =
    { myself : Me
    , bullet : List Bullet 
    , bulletViewbox : List Bullet
    , map : Map
    , rooms : (List Room,Random.Seed)
    , viewbox : Map
    , size : (Float, Float)
    , state : State
    , currentDialogues: Dialogues
    }

type State = Dialogue
           | NextStage
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

sentenceInit : Sentence
sentenceInit = Sentence "Enjoy the game now!" Bottom Monster False 0 "url(background1.jpg)"

type alias AnimationState =
    Maybe
    { active: Bool
    , elapsed: Float
    , size : (Float,Float)
    }


mapToViewBox : Me -> Map ->Map
mapToViewBox me map =
    let 
        recListUpdate model= 
            List.map (\value-> {value|x=-me.x + viewBoxMax/2 + value.x, y= -me.y + viewBoxMax/2 + value.y}) model
        recUpdate value =
            {value|x=-me.x + viewBoxMax/2 + value.x, y= -me.y + viewBoxMax/2 + value.y}
        circleUpdate value =
            {value|cx=-me.x + viewBoxMax/2 + value.cx, cy= -me.y + viewBoxMax/2 + value.cy}
        -- monsterList = map.monsters
        monsterUpdate monster= 
            {monster| position = circleUpdate monster.position}
        monstersUpdated = List.map monsterUpdate map.monsters
        -- monsterListUpdate model =
        --     List.map (\value -> {value| position = circleUpdate value.position}) model
    in
        {map| walls= recListUpdate map.walls,roads=recListUpdate map.roads, obstacles=recListUpdate map.obstacles, monsters=monstersUpdated,doors = recListUpdate map.doors,gate=recUpdate map.gate}
