module Map.Map exposing (Treasure,Obstacle,Room,Map,Monster,treasureConfig,roomConfig)
import Shape exposing (Rectangle)

type alias Monster =
    {}

type alias Treasure =
    { position : (Int,Int)
    }

type alias Obstacle =
    { position : Rectangle
    -- , type : Int
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
    , monsters : List Rectangle
    , doors : List Rectangle
    }


treasureConfig : Treasure
treasureConfig = Treasure (0,0) 

roomConfig : Room
roomConfig = Room (0,0) False False [] [] treasureConfig [] 0