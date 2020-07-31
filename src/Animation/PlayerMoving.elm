module Animation.PlayerMoving exposing (playerMove)

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
                    "#R_2"
                else
                    "#L_2" 
            else
                if me.weaponDirection==DirectionRight then 
                    if me.preDirection==DirectionRight then
                        case frameNow of
                            0->
                                "#R_1"
                            1->
                                "#R_2"
                            2->
                                "#R_3"
                            3->
                                "#R_2"
                            _ ->
                                "#R_1"
                    else
                        case frameNow of
                            0->
                                "#R_3"
                            1->
                                "#R_2"
                            2->
                                "#R_1"
                            3->
                                "#R_2"
                            _ ->
                                "#R_3"
                else
                    if me.preDirection==DirectionLeft then 
                        case frameNow of
                            0->
                                "#L_1"
                            1->
                                "#L_2"
                            2->
                                "#L_3"
                            3->
                                "#L_2"
                            _ ->
                                "#L_1"
                    else
                        case frameNow of
                            0->
                                "#L_3"
                            1->
                                "#L_2"
                            2->
                                "#L_1"
                            3->
                                "#L_2"
                            _ ->
                                "#L_1"

    in
        getUrl


