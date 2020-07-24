
module Map.Map exposing (Treasure,TreasureType,Obstacle,Room,Map,Monster,MonsterType,Wall,WallProperty(..),roomConfig,mapConfig)
import Shape exposing (Rectangle,recInit)
import Config exposing (viewBoxMax)
import Weapon exposing (Arsenal)
import Random exposing (Seed)

type alias Treasure =
    { position : Rectangle
    , treasureType : TreasureType
    , seed : Seed
    , canShow : Bool
    , roomNum : Int
    
    }

type alias TreasureType =
    {   level : Int
    ,   size : Float
    ,   color : String     
    
    }

type alias Obstacle =
    { position : Rectangle
    -- , type : Int
    }

type alias MonsterType =
    {   hp : Float
    ,   attack : Float
    ,   color : String     
       
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
    }


type alias Shootingtype =
    {   bulletNum : Int
    ,   attack : Int
    ,   direction : Int
    ,   bulletType : Arsenal
    ,   bulletsToBeShot : Int
    ,   bulletsShooted : Int
    ,   bulletInterval : Int
    ,   timeBeforeShooting : Int
        
    }

type alias BossType =
    {   level : Int
    ,   size : Rectangle 
    ,   color : String 
    ,   shootingtype : List Shootingtype    
    
    }
type alias Boss =
    { position : Shape.Circle
    , bossnum : Int
    , bosstype : BossType
    , seed : Seed
    , active : Bool
    , timeBeforeAttack : Int
    , speed : Float
    , roomNum : Int
    }


type alias Room =
    { position : (Int,Int)
    , gate : Bool
    , boss : Bool
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


type alias Map =
    { walls : List Wall
    , roads : List Rectangle
    , obstacles : List Rectangle
    , monsters : List Monster
    , treasure : List Treasure
    , doors : List Rectangle
    , gate : Rectangle
    , roomCleared : List Int
    , roomCount : Int
    , boss : List Boss
    }




roomConfig : Room
roomConfig = Room (0,0) False False [] [] [] [] 0 0

mapConfig : Map
mapConfig = Map [] [] [] [] [] [] (Rectangle 0 0 0 0 recInit) [] 0 []

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
