module Animation.ShowGun exposing (showGun)
import Model exposing (Me,Direction(..))
import Messages exposing (Msg(..))
import Weapon exposing (Arsenal(..))
import Svg 
import Svg.Attributes 


showGun : Me -> Svg.Svg Msg
showGun myself =
    let       
        pos = myself.mouseData
        px = Tuple.first pos
        py = Tuple.second pos

        theta =  (atan <|  (py-510)/  (px-500))/3.14*180 
        -- d1=Debug.log "theta"  theta
        -- (abs (py-500), abs (px-500), abs (py-500)/(abs (px-500)))
        weaponNow = myself.currentWeapon
        showPistol=
            if myself.weaponDirection == DirectionRight then
                Svg.use [Svg.Attributes.x "500", Svg.Attributes.y "500", Svg.Attributes.xlinkHref "#Gun_1_R", Svg.Attributes.preserveAspectRatio "none meet", 
                    Svg.Attributes.width "20", Svg.Attributes.height "20",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 510)")][]
            else 
                Svg.use [Svg.Attributes.x "480", Svg.Attributes.y "500", Svg.Attributes.xlinkHref "#Gun_1_L", Svg.Attributes.preserveAspectRatio "none meet", 
                    Svg.Attributes.width "20", Svg.Attributes.height "20",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 510)")][]
        
        showGatling=
            if myself.weaponDirection == DirectionRight then
                Svg.use [Svg.Attributes.x "490", Svg.Attributes.y "500", Svg.Attributes.xlinkHref "#Gun_2_R", Svg.Attributes.preserveAspectRatio "none meet", 
                    Svg.Attributes.width "30", Svg.Attributes.height "16",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 510)")][]
            else 
                Svg.use [Svg.Attributes.x "480", Svg.Attributes.y "500", Svg.Attributes.xlinkHref "#Gun_2_L", Svg.Attributes.preserveAspectRatio "none meet", 
                    Svg.Attributes.width "30", Svg.Attributes.height "16",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 510)")][]
        
        showMortar=
            if myself.weaponDirection == DirectionRight then
                Svg.use [Svg.Attributes.x "490", Svg.Attributes.y "490", Svg.Attributes.xlinkHref "#Gun_3_R", Svg.Attributes.preserveAspectRatio "none meet", 
                    Svg.Attributes.width "40", Svg.Attributes.height "40",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 510)")][]
            else 
                Svg.use [Svg.Attributes.x "470", Svg.Attributes.y "490", Svg.Attributes.xlinkHref "#Gun_3_L", Svg.Attributes.preserveAspectRatio "none meet", 
                    Svg.Attributes.width "40", Svg.Attributes.height "40",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 510)")][]

        showShotgun=
            if myself.weaponDirection == DirectionRight then
                Svg.use [Svg.Attributes.x "490", Svg.Attributes.y "500", Svg.Attributes.xlinkHref "#Gun_4_R", Svg.Attributes.preserveAspectRatio "none meet", 
                    Svg.Attributes.width "40", Svg.Attributes.height "20",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 510)")][]
            else 
                Svg.use [Svg.Attributes.x "470", Svg.Attributes.y "500", Svg.Attributes.xlinkHref "#Gun_4_L", Svg.Attributes.preserveAspectRatio "none meet", 
                    Svg.Attributes.width "40", Svg.Attributes.height "20",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 510)")][]

    in
        case weaponNow.extraInfo of
            Pistol ->
                showPistol
            Gatling->
                showGatling
            Mortar->
                showMortar
            Shotgun->
                showShotgun
