module Bomb exposing (Bomb, placeBomb)
import Array exposing (isEmpty)

timeCountDown : Int
timeCountDown = 100

type alias Bombs = 
    { waiting : List Bombs
    , display : List Bombs
    }

type alias Bomb = 
    { x : Float
    , y : Float
    , r : Float
    , counter : Int     -- count down from 100 to 10, explode at 10 and disappear at 0
    }

placeBomb : (Int, Int) -> Bomb
placeBomb (x, y) =
    Bomb x y 30 (timeCountDown+10)

isExplodeNow : Bomb -> Bool
isExplodeNow bomb = 
    bomb.counter == 10

canRemove : Bomb -> Bool
canRemove bomb =
    bomb.counter <= 0

bombTick : List Bomb -> Bombs -> (Bombs, List Bomb)
bombTick newBomb bombs =
    let
        next b = {b|counter = b.counter - 1}
        newWaiting = List.map next bombs.waiting
        newDisplay = List.map next bombs.display
        (explode, stillWait) = List.partition isExplodeNow newWaiting
        stillDisplay = List.filter (\b -> not <| isExplodeNow b) newDisplay
        finalWait = stillWait ++ newBomb
        finalDisplay = stillDisplay ++ explode
    in
        ((Bombs finalWait finalDisplay), explode)

