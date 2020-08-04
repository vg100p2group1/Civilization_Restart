
module Model exposing (Me,Model,State(..), Dialogues, Sentence, Side(..), Role(..),Direction(..),AnimationState,
                       defaultMe, sentenceInit,mapToViewBox, GameState(..), WeaponUnlockSys,Page(..),defaultTraining,
                       TrainingSession)
import Random
import Map.Map exposing(Room,Map,Treasure)
import Shape exposing (Circle)
import Weapon exposing (Bullet,Weapon,weaponList,defaultWeapon,ExplosionEffect,Arsenal(..))
import Config exposing (playerSpeed,viewBoxMax)
import Skill exposing (SkillSystem, defaultSystem)
import Attributes exposing (Attr,defaultAttr)
import Synthesis.Package exposing (Package,packageInit)
import Synthesis.SynthesisSystem exposing (SynthesisSubSystem,defaultSynthesisSubSystem)
import Bomb exposing (Bombs)
import Dict exposing (Dict)
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
    , fire : Bool
    , dualWield : Int
    , absoluteTerrifyField : Int
    , flash : Int
    , invisible : Int
    , directionalBlasting : Int
  --   , name : String
  --   , score : Float
    , hitBox : Circle
    , weapons : List Weapon 
    , currentWeapon : Weapon
    , counter : Int
    , url : String
    , preDirection : Direction
    , weaponDirection : Direction
    -- , direction : Int 
    , skillSys : SkillSystem
    , attr : Attr
    , synthesis : SynthesisSubSystem
    , package : Package 
    , time : Int
    , arsenal : List Weapon
    , weaponUnlockSys : WeaponUnlockSys
    , addAudio : List String
    }

type alias WeaponUnlockSys =
    { active : Bool
    , canUnlockWeapon : Bool
    , chosen : Arsenal
    , unlockedWeapons : List Weapon
    , tip : String
    }

defaultWeaponUnlockSys =
    { active = False
    , canUnlockWeapon = True
    , chosen = Pistol
    , unlockedWeapons = [defaultWeapon]
    , tip = ""
    }

type Direction
    = DirectionRight
    | DirectionLeft


defaultMe : Me
defaultMe = 
    { x = 500
    , y = 500
    , r = 20
    , xSpeed = playerSpeed
    , ySpeed = 0
    , rotate = 0
    , moveUp = False
    , moveRight = False
    , moveLeft = False
    , moveDown = False
    , mouseData = (500,500)
    , fire = False
    , dualWield = 0
    , absoluteTerrifyField = 0
    , flash = 0
    , invisible = 0
    , directionalBlasting = 0
    , hitBox = Circle 500 500 20
    , weapons = [defaultWeapon]
    , currentWeapon = defaultWeapon
    , counter = 0
    , url = ""
    , preDirection = DirectionRight
    , weaponDirection = DirectionRight
    , skillSys = defaultSystem
    , attr = defaultAttr
    , synthesis = defaultSynthesisSubSystem
    , package = packageInit 
    , time = 0
    , arsenal = weaponList
    , weaponUnlockSys = defaultWeaponUnlockSys
    ,addAudio= []
    }

type alias Model =
    { myself : Me
    , bullet : List Bullet 
    , bulletViewbox : List Bullet
    , map : Map
    , rooms : (List Room,Random.Seed)
    , viewbox : Map
    , size : (Float, Float)
    , state : State
    , currentDialogues : Dialogues
    , explosion : List ExplosionEffect
    , explosionViewbox : List ExplosionEffect
    , paused : Bool
    , gameState : GameState
    , storey : Int
    , isGameOver : Bool
    , pageState : Page
    , bomb : Bombs
    , wholeCounter : Int
    , trainingSession : TrainingSession
    }

type alias TrainingSession =
    { step : Int
    , hasMovedLeft : Bool
    , hasMovedUp : Bool
    , hasFired : Bool
    , hasB : Bool
    , hasR : Bool
    , tips : Dict Int String
    }


defaultTips : Dict Int String
defaultTips = Dict.fromList
              [ (1, "Press A and D to Move Left and Right")
              , (2, "Press W and S to Move Up and Down")
              , (3, "Clicking the mouse to Shoot")
              , (4, "Press B to Open the Skill Tree System")
              , (5, "Press R to open the Synthesis System")
              , (6, "Press Enter to Start your adventure!")
              ]


defaultTraining : TrainingSession
defaultTraining =
    { step = 1
    , hasMovedLeft = False
    , hasMovedUp = False
    , hasFired = False
    , hasB = False
    , hasR = False
    , tips = defaultTips
    }

type Page = WelcomePage
          | HelpPage
          | GamePage
          | StoryPage
          | AboutPage   

type State = Dialogue
           | NextStage
           | ChangeSkill
           | PickTreasure Treasure
           | SynthesisSys
           | SkillSys
           | OnTraining
           | Others
           | Unlocking

type GameState = Paused
               | Playing
               | Stopped

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
        wallListUpdate model =
            List.map (\value-> {value|position=recUpdate value.position}) model
        -- monsterList = map.monsters
        monsterUpdate monster= 
            {monster| position = circleUpdate monster.position}
        monstersUpdated = List.map monsterUpdate map.monsters
        treasureUpdate monster= 
            {monster| position = recUpdate monster.position}
            
        bossUpdate boss= 
            {boss| position = recUpdate boss.position}
        bossesUpdated =  List.map bossUpdate map.boss
        treasureUpdated = List.map treasureUpdate map.treasure

        doorsUpdate doors =
            List.map (\value -> {value|position=recUpdate value.position}) doors
        
        gateUpdate gate= 
            {gate| position = recUpdate gate.position}
        -- monsterListUpdate model =
        --     List.map (\value -> {value| position = circleUpdate value.position}) model
    in
        {map| walls= wallListUpdate map.walls,roads=recListUpdate map.roads, obstacles=recListUpdate map.obstacles, monsters=monstersUpdated,doors = doorsUpdate map.doors,treasure=treasureUpdated,gate=gateUpdate map.gate,boss=bossesUpdated}
