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

        theta =  (atan <|  (py-520)/  (px-500))/3.14*180 
        -- d1=Debug.log "theta"  theta
        -- (abs (py-500), abs (px-500), abs (py-500)/(abs (px-500)))
        weaponNow = myself.currentWeapon
        showPistol=
            if myself.weaponDirection == DirectionRight then
                Svg.image [Svg.Attributes.x "500", Svg.Attributes.y "500", Svg.Attributes.xlinkHref "./images/Gun/Gun_1_R.png", Svg.Attributes.preserveAspectRatio "none meet", 
                    Svg.Attributes.width "40", Svg.Attributes.height "40",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 520)")][]
            else 
                Svg.image [Svg.Attributes.x "460", Svg.Attributes.y "500", Svg.Attributes.xlinkHref "./images/Gun/Gun_1_L.png", Svg.Attributes.preserveAspectRatio "none meet", 
                    Svg.Attributes.width "40", Svg.Attributes.height "40",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 520)")][]
        
        showGatling=
            if myself.weaponDirection == DirectionRight then
                Svg.image [Svg.Attributes.x "480", Svg.Attributes.y "495", Svg.Attributes.xlinkHref "./images/Gun/Gun_2_R.png", Svg.Attributes.preserveAspectRatio "none meet", 
                    Svg.Attributes.width "60", Svg.Attributes.height "40",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 520)")][]
            else 
                Svg.image [Svg.Attributes.x "460", Svg.Attributes.y "495", Svg.Attributes.xlinkHref "./images/Gun/Gun_2_L.png", Svg.Attributes.preserveAspectRatio "none meet", 
                    Svg.Attributes.width "60", Svg.Attributes.height "40",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 520)")][]
        
        showMortar=
            if myself.weaponDirection == DirectionRight then
                Svg.image [Svg.Attributes.x "480", Svg.Attributes.y "485", Svg.Attributes.xlinkHref "./images/Gun/Gun_3_R.png", Svg.Attributes.preserveAspectRatio "none meet", 
                    Svg.Attributes.width "80", Svg.Attributes.height "80",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 520)")][]
            else 
                Svg.image [Svg.Attributes.x "440", Svg.Attributes.y "485", Svg.Attributes.xlinkHref "./images/Gun/Gun_3_L.png", Svg.Attributes.preserveAspectRatio "none meet", 
                    Svg.Attributes.width "80", Svg.Attributes.height "80",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 520)")][]

        showShotgun=
            if myself.weaponDirection == DirectionRight then
                Svg.image [Svg.Attributes.x "480", Svg.Attributes.y "500", Svg.Attributes.xlinkHref "./images/Gun/Gun_4_R.png", Svg.Attributes.preserveAspectRatio "none meet", 
                    Svg.Attributes.width "80", Svg.Attributes.height "40",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 520)")][]
            else 
                Svg.image [Svg.Attributes.x "440", Svg.Attributes.y "500", Svg.Attributes.xlinkHref "./images/Gun/Gun_4_L.png", Svg.Attributes.preserveAspectRatio "none meet", 
                    Svg.Attributes.width "80", Svg.Attributes.height "40",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 520)")][]

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
