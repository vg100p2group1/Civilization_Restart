module Animation.ShowBullet exposing (showBullets)
import Model exposing (Me,Direction(..))
import Messages exposing (Msg(..))
import Weapon exposing (Arsenal(..),Bullet,ShooterType(..))
import Svg 
import Svg.Attributes 


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