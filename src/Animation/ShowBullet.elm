module Animation.ShowBullet exposing (showBullets)
import Model exposing (Direction(..))
import Messages exposing (Msg(..))
import Weapon exposing (Arsenal(..),Bullet,ShooterType(..))
import Svg 
import Svg.Attributes 
import Shape exposing(circleRecTest,Rec,Circle)

showBullets : List Bullet -> List ( Svg.Svg Msg) 
showBullets bullets =
    let 
        
        createBulletFormat model =
            let
                theta = 90-(atan  (model.speedX/model.speedY) )/3.14*180
                -- d1=Debug.log "theta" (model.speedX,model.speedY,theta)
            in
                if  model.from==Player then
                    -- if model.speedX > 0 then
                        if model.speedY>0 then  
                            Svg.use [Svg.Attributes.x <| String.fromFloat (model.x-model.r*2.5), Svg.Attributes.y <| String.fromFloat (model.y-model.r*2.5), Svg.Attributes.xlinkHref "#Bullet1_R", Svg.Attributes.preserveAspectRatio "none meet", 
                                Svg.Attributes.width <| String.fromFloat (model.r*5), Svg.Attributes.height <| String.fromFloat (model.r*5),Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" "++String.fromFloat model.x++" "++ String.fromFloat model.y++")")][]
                        else
                            Svg.use [Svg.Attributes.x <| String.fromFloat (model.x-model.r*2.5), Svg.Attributes.y <| String.fromFloat (model.y-model.r*2.5), Svg.Attributes.xlinkHref "#Bullet1", Svg.Attributes.preserveAspectRatio "none meet", 
                                Svg.Attributes.width <| String.fromFloat (model.r*5), Svg.Attributes.height <| String.fromFloat (model.r*5),Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" "++String.fromFloat model.x++" "++ String.fromFloat model.y++")")][]
                else
                    if model.speedY > 0 then 
                        Svg.use [Svg.Attributes.x <| String.fromFloat (model.x-model.r*2.5), Svg.Attributes.y <| String.fromFloat (model.y-model.r*2.5), Svg.Attributes.xlinkHref "#Bullet2_R", Svg.Attributes.preserveAspectRatio "none meet", 
                            Svg.Attributes.width <| String.fromFloat (model.r*5), Svg.Attributes.height <| String.fromFloat (model.r*5),Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" "++String.fromFloat model.x++" "++ String.fromFloat model.y++")")][]
                    else
                        Svg.use [Svg.Attributes.x <| String.fromFloat (model.x-model.r*2.5), Svg.Attributes.y <| String.fromFloat (model.y-model.r*2.5), Svg.Attributes.xlinkHref "#Bullet2", Svg.Attributes.preserveAspectRatio "none meet", 
                            Svg.Attributes.width <| String.fromFloat (model.r*5), Svg.Attributes.height <| String.fromFloat (model.r*5),Svg.Attributes.transform ("rotate("++ String.fromFloat theta++" "++String.fromFloat model.x++" "++ String.fromFloat model.y++")"),
                            Svg.Attributes.scale "(-1,1)"][]
    in
        List.map createBulletFormat <| List.filter (\value-> circleRecTest (Circle value.x value.y value.r)  (Rec 0 0 1000 1000) ) bullets