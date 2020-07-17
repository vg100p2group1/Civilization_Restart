module Move.PlayerMoving exposing (playerMove)

-- import Html exposing (Html)
import Svg 
import Svg.Attributes

import Model exposing (Me)


playerMove : Me -> Svg.Svg msg
playerMove me =
    let
        counternow = me.counter
        framesAll = counternow//7
        frameNow = modBy 4 framesAll 
        getUrl = 
            case frameNow of
                0->
                    "./images/1.png"
                1->
                    "./images/2.png"
                2->
                    "./images/3.png"
                3->
                    "./images/2.png"
                _ ->
                    "./images/1.png"
      
    in
        Svg.image [Svg.Attributes.x "460", Svg.Attributes.y "460", Svg.Attributes.xlinkHref getUrl, Svg.Attributes.preserveAspectRatio "none meet", 
                   Svg.Attributes.width "80", Svg.Attributes.height "80"][]


