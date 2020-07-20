module Animation.ShowBullet exposing (showBullets)
import Model exposing (Me,Direction(..))
import Messages exposing (Msg(..))
import Weapon exposing (Arsenal(..),Bullet,ShooterType(..))
import Svg 
import Svg.Attributes 


-- showBullet : Me -> Svg.Svg Msg
-- showBullet myself =
--     let       
--         pos = myself.mouseData
--         px = Tuple.first pos
--         py = Tuple.second pos

--         theta =  (atan <|  (py-520)/  (px-500))/3.14*180 
--         -- d1=Debug.log "theta"  theta
--         -- (abs (py-500), abs (px-500), abs (py-500)/(abs (px-500)))
--         weaponNow = myself.currentWeapon
--         showPistol=
--             if myself.weaponDirection == DirectionRight then
--                 Svg.image [Svg.Attributes.x "500", Svg.Attributes.y "500", Svg.Attributes.xlinkHref "./images/Gun/Gun_1_R.png", Svg.Attributes.preserveAspectRatio "none meet", 
--                     Svg.Attributes.width "40", Svg.Attributes.height "40",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 520)")][]
--             else 
--                 Svg.image [Svg.Attributes.x "460", Svg.Attributes.y "500", Svg.Attributes.xlinkHref "./images/Gun/Gun_1_L.png", Svg.Attributes.preserveAspectRatio "none meet", 
--                     Svg.Attributes.width "40", Svg.Attributes.height "40",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 520)")][]
        
--         showGatling=
--             if myself.weaponDirection == DirectionRight then
--                 Svg.image [Svg.Attributes.x "480", Svg.Attributes.y "495", Svg.Attributes.xlinkHref "./images/Gun/Gun_2_R.png", Svg.Attributes.preserveAspectRatio "none meet", 
--                     Svg.Attributes.width "60", Svg.Attributes.height "40",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 520)")][]
--             else 
--                 Svg.image [Svg.Attributes.x "460", Svg.Attributes.y "495", Svg.Attributes.xlinkHref "./images/Gun/Gun_2_L.png", Svg.Attributes.preserveAspectRatio "none meet", 
--                     Svg.Attributes.width "60", Svg.Attributes.height "40",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 520)")][]
        
--         showMortar=
--             if myself.weaponDirection == DirectionRight then
--                 Svg.image [Svg.Attributes.x "480", Svg.Attributes.y "485", Svg.Attributes.xlinkHref "./images/Gun/Gun_3_R.png", Svg.Attributes.preserveAspectRatio "none meet", 
--                     Svg.Attributes.width "80", Svg.Attributes.height "80",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 520)")][]
--             else 
--                 Svg.image [Svg.Attributes.x "440", Svg.Attributes.y "485", Svg.Attributes.xlinkHref "./images/Gun/Gun_3_L.png", Svg.Attributes.preserveAspectRatio "none meet", 
--                     Svg.Attributes.width "80", Svg.Attributes.height "80",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 520)")][]

--         showShotgun=
--             if myself.weaponDirection == DirectionRight then
--                 Svg.image [Svg.Attributes.x "480", Svg.Attributes.y "500", Svg.Attributes.xlinkHref "./images/Gun/Gun_4_R.png", Svg.Attributes.preserveAspectRatio "none meet", 
--                     Svg.Attributes.width "80", Svg.Attributes.height "40",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 520)")][]
--             else 
--                 Svg.image [Svg.Attributes.x "440", Svg.Attributes.y "500", Svg.Attributes.xlinkHref "./images/Gun/Gun_4_L.png", Svg.Attributes.preserveAspectRatio "none meet", 
--                     Svg.Attributes.width "80", Svg.Attributes.height "40",Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" 500 520)")][]

--     in
--         case weaponNow.extraInfo of
--             Pistol ->
--                 showPistol
--             Gatling->
--                 showGatling
--             Mortar->
--                 showMortar
--             Shotgun->
--                 showShotgun


showBullets : List Bullet -> List ( Svg.Svg Msg) 
showBullets bullets =
    let 
        
        createBulletFormat model =
            let
                theta = 90-(atan  (model.speedX/model.speedY) )/3.14*180
                -- d1=Debug.log "theta" (model.speedX,model.speedY,theta)
            in
                if  model.from==Player then
                    if model.speedX > 0 then 
                        Svg.image [Svg.Attributes.x <| String.fromFloat (model.x-model.r*2.5), Svg.Attributes.y <| String.fromFloat (model.y-model.r*2.5), Svg.Attributes.xlinkHref "./images/Gun/Bullet1.png", Svg.Attributes.preserveAspectRatio "none meet", 
                            Svg.Attributes.width <| String.fromFloat (model.r*5), Svg.Attributes.height <| String.fromFloat (model.r*5),Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" "++String.fromFloat model.x++" "++ String.fromFloat model.y++")")][]
                    else
                        Svg.image [Svg.Attributes.x <| String.fromFloat (model.x-model.r*2.5), Svg.Attributes.y <| String.fromFloat (model.y-model.r*2.5), Svg.Attributes.xlinkHref "./images/Gun/Bullet1.png", Svg.Attributes.preserveAspectRatio "none meet", 
                            Svg.Attributes.width <| String.fromFloat (model.r*5), Svg.Attributes.height <| String.fromFloat (model.r*5),Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" "++String.fromFloat model.x++" "++ String.fromFloat model.y++")"),
                            Svg.Attributes.scale "(-1,1)"][]
                else
                    if model.speedX > 0 then 
                        Svg.image [Svg.Attributes.x <| String.fromFloat (model.x-model.r*2.5), Svg.Attributes.y <| String.fromFloat (model.y-model.r*2.5), Svg.Attributes.xlinkHref "./images/Gun/Bullet2.png", Svg.Attributes.preserveAspectRatio "none meet", 
                            Svg.Attributes.width <| String.fromFloat (model.r*5), Svg.Attributes.height <| String.fromFloat (model.r*5),Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" "++String.fromFloat model.x++" "++ String.fromFloat model.y++")")][]
                    else
                        Svg.image [Svg.Attributes.x <| String.fromFloat (model.x-model.r*2.5), Svg.Attributes.y <| String.fromFloat (model.y-model.r*2.5), Svg.Attributes.xlinkHref "./images/Gun/Bullet2.png", Svg.Attributes.preserveAspectRatio "none meet", 
                            Svg.Attributes.width <| String.fromFloat (model.r*5), Svg.Attributes.height <| String.fromFloat (model.r*5),Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" "++String.fromFloat model.x++" "++ String.fromFloat model.y++")"),
                            Svg.Attributes.scale "(-1,1)"][]
    in
        List.map createBulletFormat bullets