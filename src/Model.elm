module Model exposing (Rectangle,Rec,Circle,Player,Me,Model,Bullet,recCollisionTest,recUpdate)


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

type alias Circle =
    { cx : Float
    , cy : Float
    , r : Float
    }

type alias Player = 
    { x : Float
    , y : Float
    , r : Float
    , rotate : Float
    , hitBox : Circle
    }

type alias Bullet =
    { x : Float 
    , y : Float
    , r : Float
    , speedX : Float
    , speedY : Float
    , collision : Bool
    , hitBox : Circle
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
    , hitBox : Circle
    }

type alias Model =
    { walls : List Rectangle
    , other : List Player
    , myself :  Me
    , viewbox : List Rectangle
    , bullet : List Bullet 
    , bulletViewbox : List Bullet
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

circleRecTest : Circle -> Rec -> Bool
circleRecTest circle rec =
    let
        relativeX = circle.cx - rec.cx
        relativeY = circle.cy - rec.cy
        dx = clamp -rec.halfWidth rec.halfWidth relativeX
        dy = clamp -rec.halfHeight rec.halfHeight relativeY
    in
        (dx - relativeX) ^ 2 + (dy - relativeY) ^ 2 < circle.r ^ 2

circleCollisonTest : Circle -> Circle -> Bool
circleCollisonTest c1 c2 =
    sqrt((c1.cx - c2.cx) ^ 2 + (c1.cy - c2.cy) ^ 2) <= c1.r + c2.r
