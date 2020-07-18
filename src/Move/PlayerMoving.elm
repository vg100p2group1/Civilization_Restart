module Move.PlayerMoving exposing (playerMove)

-- import Html exposing (Html)


import Model exposing (Me,Direction(..))


playerMove : Me -> String
playerMove me =
    let
        counternow = me.counter
        framesAll = counternow//7
        frameNow = modBy 4 framesAll 
        
        -- d1=Debug.log "direction u r l d"    (me.moveUp&&me.moveRight&&me.moveLeft&&me.moveDown)
        getUrl = 
            if me.moveUp==False && me.moveRight==False && me.moveLeft==False && me.moveDown==False  then 
                if me.weaponDirection==DirectionRight then
                    "./images/R_2.png"
                else
                    "./images/L_2.png" 
            else
                if me.weaponDirection==DirectionRight then 
                    if me.preDirection==DirectionRight then
                        case frameNow of
                            0->
                                "./images/R_1.png"
                            1->
                                "./images/R_2.png"
                            2->
                                "./images/R_3.png"
                            3->
                                "./images/R_2.png"
                            _ ->
                                "./images/R_1.png"
                    else
                        case frameNow of
                            0->
                                "./images/R_3.png"
                            1->
                                "./images/R_2.png"
                            2->
                                "./images/R_1.png"
                            3->
                                "./images/R_2.png"
                            _ ->
                                "./images/R_3.png"
                else
                    if me.preDirection==DirectionLeft then 
                        case frameNow of
                            0->
                                "./images/L_1.png"
                            1->
                                "./images/L_2.png"
                            2->
                                "./images/L_3.png"
                            3->
                                "./images/L_2.png"
                            _ ->
                                "./images/L_1.png"
                    else
                        case frameNow of
                            0->
                                "./images/L_3.png"
                            1->
                                "./images/L_2.png"
                            2->
                                "./images/L_1.png"
                            3->
                                "./images/L_2.png"
                            _ ->
                                "./images/L_1.png"

    in
        getUrl


