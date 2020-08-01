module Bomb exposing (Bomb, placeBomb)

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