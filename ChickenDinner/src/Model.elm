module Model exposing (Rectangle,Rec,Player,Me,Model,Bullet,recCollisionTest,recUpdate,Room,Treasure,Map)
import Random

-- type alias MouseMoveData =
--     { offsetX : Int
--     , offsetY : Int
--     , offsetHeight : Float
--     , offsetWidth : Float
--     }

type alias Rec =
    { cx : Float
    , cy : Float
    , halfWidth : Float
    , halfHeight : Float
    }

type alias Rectangle = 
    { x : Float
    , y : Float
    , width : Float
    , height : Float
    , edge : Rec
    }

type alias Player = 
    { x : Float
    , y : Float
    , r : Float
    , rotate : Float
    , name : String
    , score : Float
    , die : Bool
    }

type alias Bullet =
    { x : Float 
    , y : Float
    , r : Float
    , speedX : Float
    , speedY : Float
    , collision : Bool
    }

type alias Obstacle = 
    {} 

type alias Monster =
    {}

type alias Treasure =
    { position : (Int,Int)
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
      , edge : Rec
      , mouseData : (Float,Float)
      , fire : Bool -- 到时候用sum type
      , name : String
      , score : Float 
    }

type alias Model =
    { 
      myself :  Me    
    , bullet : List Bullet 
    , bulletViewbox : List Bullet
    , map : Map
    , rooms : (List Room,Random.Seed)
    , viewbox : Map
    }


recCollisionTest : Rec -> Rec -> Bool
recCollisionTest rec1 rec2 =
    (abs(rec1.cx - rec2.cx) < rec1.halfWidth + rec2.halfWidth) && (abs(rec1.cy - rec2.cy) < rec1.halfHeight + rec2.halfHeight)

recUpdate : Rectangle -> Rectangle
recUpdate model = 
    let
        halfx = model.width / 2
        halfy = model.height /2
        newx = model.x + halfx
        newy = model.y + halfy
        newRec = Rec newx newy halfx halfy
    in 
        { model| edge = newRec}