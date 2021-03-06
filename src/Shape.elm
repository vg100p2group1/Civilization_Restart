module Shape exposing (Rec,Rectangle,Circle,CollideDirection(..),recInit,recCollisionTest,recUpdate,circleRecTest,circleCollisonTest,circleInit,circleRecDirection)

-- import Css exposing (relative)

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

recInit : Rec
recInit = Rec 0 0 0 0

circleInit : Circle
circleInit = Circle 0 0 0

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

type CollideDirection 
    =FromLeft Float 
    |FromRight Float 
    |FromUp Float
    |FromDown Float 
    -- |FromLeftUp
    -- |FromLeftDown
    -- |FromRightUp
    -- |FromRightDown
    |NoCollide Float

circleRecDirection : Circle -> Rec -> CollideDirection
circleRecDirection circle rec =
    let
        relativeX = circle.cx - rec.cx
        relativeY = circle.cy - rec.cy
        dx = clamp -rec.halfWidth rec.halfWidth relativeX
        dy = clamp -rec.halfHeight rec.halfHeight relativeY
        collide =  (dx - relativeX) ^ 2 + (dy - relativeY) ^ 2 < circle.r ^ 2
        

        getCollideType =
            if collide then
                
                if (rec.cx-rec.halfWidth<=circle.cx)&&(rec.cx + rec.halfWidth>=circle.cx)  && relativeY> 0 then
                    FromDown (relativeY-rec.halfHeight-circle.r)
                else if (rec.cx-rec.halfWidth<=circle.cx)&&(rec.cx + rec.halfWidth>=circle.cx)  && relativeY< 0 then 
                    FromUp (rec.halfHeight+circle.r+relativeY)
                else if (rec.cx+rec.halfWidth<=circle.cx) && relativeX> 0 then
                    FromRight (relativeX-rec.halfWidth-circle.r)
                else if (rec.cx-rec.halfWidth>=circle.cx) && relativeX< 0 then
                    FromLeft (relativeX+rec.halfWidth+circle.r)
                -- else if relativeX<0 && relativeY<0 then
                --     FromLeftUp
                -- else if relativeX<0 && relativeY>0 then
                --     FromLeftDown
                -- else if relativeX>0 && relativeY<0 then
                --     FromRightUp
                -- else if relativeX>0 && relativeY>0 then
                --     FromRightDown
                else
                    NoCollide 0
            else 
                NoCollide 0
    in
        getCollideType