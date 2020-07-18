module ShowGun exposing (showGun)
import Model exposing (Me,Direction(..))
import Messages exposing (Msg(..))

import Svg 
import Svg.Attributes 


showGun : Me -> Svg.Svg Msg
showGun myself =
    let       
        pos = myself.mouseData
        px = Tuple.first pos
        py = Tuple.second pos

        theta =  (atan <|  (py-520)/  (px-500))/3.14*180 
        -- d1=Debug.log "theta"  theta
        -- (abs (py-500), abs (px-500), abs (py-500)/(abs (px-500)))

    in
        if myself.weaponDirection == DirectionRight then
            Svg.image [Svg.Attributes.x "500", Svg.Attributes.y "500", Svg.Attributes.xlinkHref "./images/Gun_1_R.png", Svg.Attributes.preserveAspectRatio "none meet", 
                Svg.Attributes.width "40", Svg.Attributes.height "40",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 520)")][]
        else 
            Svg.image [Svg.Attributes.x "460", Svg.Attributes.y "500", Svg.Attributes.xlinkHref "./images/Gun_1_L.png", Svg.Attributes.preserveAspectRatio "none meet", 
                Svg.Attributes.width "40", Svg.Attributes.height "40",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 520)")][]