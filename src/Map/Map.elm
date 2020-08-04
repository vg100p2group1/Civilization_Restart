

module Map.Map exposing (Treasure,TreasureType,Obstacle,Room,Map,Monster,MonsterType,Wall,WallProperty(..),roomConfig,mapConfig,treasureInit,Door,Boss,BossType,ShootingType,AttackMode(..),Aint,Gate)
import Shape exposing (Rectangle,recInit)
import Random exposing (Seed)
import Synthesis.Material exposing (Material)
type alias Treasure =
    { position : Rectangle
    , treasureType : TreasureType
    , seed : Seed
    , canShow : Bool
    , roomNum : Int
    , material : Material
    }

treasureInit : Treasure
treasureInit =
    Treasure (Rectangle 0 0 0 0 recInit) (TreasureType 0 0 "") (Random.initialSeed 0) False 0 (Material 0 0 0 0)

type alias TreasureType =
    {   level : Int
    ,   size : Float
    ,   color : String      
    }

type alias Obstacle =
    { position : Rectangle
    -- , type : Int
    }

type alias Gate =
    { position : Rectangle
    , counter : Int
    , roomNum : Int
    , canShow : Bool
    }

type alias MonsterType =
    { hp : Float
    , attack : Float
    , url : String
    , maxHp : Float
    }
type alias Monster =
    { position : Shape.Circle
    , region : Rectangle
    , monsterType : MonsterType
    , direction : Int
    , seed : Seed
    , active : Bool
    , timeBeforeAttack : Int
    , speed : Float
    , roomNum : Int
    , face : Bool
    }

type AttackMode 
    = Circled
    | Targeted

type alias ShootingType =
    {   attackMode : AttackMode
    ,    bulletNum : Int
    ,   direction : Float
    ,   attack : Float
    ,   speed : Float
    ,   r : Float
    -- ,   bulletsToBeShot : Int
    -- ,   bulletsShooted : Int
    ,   bulletInterval : Int
        
    }

type alias BossType =
    {    hp : Float
    ,   level : Int
    ,   width : Float
    ,   height : Float
    ,   url : String 
    ,   shootingType : List ShootingType    
    
    }
type alias Boss =
    { position : Rectangle
    , bossnum : Int
    , bossType : BossType
    , seed : Seed
    , active : Bool
    , timeBeforeAttack : Int
    , roomNum : Int
    }


type alias Room =
    { position : (Int,Int)
    , gate : Bool
    , haveBoss : Bool
    , boss : List Boss
    , obstacles : List Obstacle
    , monsters : List Monster
    , treasure : List Treasure
    , road : List (Int,Int) -- 邻接表
    , rank : Int -- rank 越低，怪难度越高？
    , roomNum : Int
    }

type WallProperty
    =UpWall
    |DownWall
    |RightWall
    |LeftWall


type alias Wall =
    {   position : Rectangle
      , property : WallProperty
    }

type alias Door =
    {
        position : Rectangle
    ,   enable : Bool
    }
type alias Map =
    { walls : List Wall
    , roads : List Rectangle
    , obstacles : List Rectangle
    , monsters : List Monster
    , treasure : List Treasure
    , doors : List Door
    , gate : Gate
    , roomCleared : List Int
    , roomCount : Int
    , boss : List Boss
    }

type alias Aint =
  { dieFace : Int
  }



roomConfig : Room
roomConfig = Room (0,0) False False [] [] [] [] [] 0 0

mapConfig : Map
mapConfig = Map [] [] [] [] [] [] (Gate (Rectangle 0 0 0 0 recInit) 0 0 False) [] 0 []

{-
initMapUpdate : Me -> (List Rectangle) -> (List Rectangle)
initMapUpdate me model =
    List.map (\value-> {value|x=me.x + viewBoxMax/2 + value.x, y= me.y + viewBoxMax/2 + value.y}) model
-}

{-
initMapUpdate : (Float, Float) -> (List Rectangle) -> (List Rectangle)
initMapUpdate (mePosX, mePosY) model =
    List.map (\value-> {value|x=mePosX + viewBoxMax/2 + value.x, y= mePosY + viewBoxMax/2 + value.y}) model
-}
