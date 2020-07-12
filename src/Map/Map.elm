
module Map.Map exposing (Treasure,Obstacle,Room,Map,Monster,MonsterType,treasureConfig,roomConfig,mapConfig)
import Shape exposing (Rectangle,recInit)
import Config exposing (viewBoxMax)

type alias Treasure =
    { position : (Int,Int)
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
    }


type alias Room =
    { position : (Int,Int)
    , gate : Bool
    , boss : Bool
    , obstacles : List Obstacle
    , monsters : List Monster
    , treasure : Treasure
    , road : List (Int,Int) -- 邻接表
    , rank : Int -- rank 越低，怪难度越高？
    }

type alias Map =
    { walls : List Rectangle
    , roads : List Rectangle
    , obstacles : List Rectangle
    , monsters : List Monster
    , doors : List Rectangle
    , gate : Rectangle
    }


treasureConfig : Treasure
treasureConfig = Treasure (0,0) 

roomConfig : Room
roomConfig = Room (0,0) False False [] [] treasureConfig [] 0

mapConfig : Map
mapConfig = Map [] [] [] [] [] (Rectangle 0 0 0 0 recInit)

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
