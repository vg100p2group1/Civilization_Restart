module Pages.Welcome exposing (welcomeView)
import Html exposing (Html, div, h1,text, ul, li,p,a,canvas, video)
import Html.Attributes exposing (style,class,href,id,disabled,src,loop,controls,autoplay)
import Html.Events exposing (onClick)
import Html.Events.Extra.Mouse as Mouse
import Svg 
import Svg.Attributes 
import Model exposing (Model)
import Messages exposing (Msg(..),PageMsg(..))
-- import 

welcomeView : Model -> Html Msg
welcomeView model =
    let
        ( w, h ) =
            model.size
        
        configheight =1000
        configwidth = 1000
        r =
            if w / h > 1 then
                Basics.min 1 (h / configwidth)

            else
                Basics.min 1 (w / configheight)
    in
        Html.div
                [ 
                    Html.Attributes.style "width" (String.fromFloat configwidth ++ "px")
                    , Html.Attributes.style "height" (String.fromFloat configheight ++ "px")
                    , Html.Attributes.style "position" "absolute"
                    , Html.Attributes.style "left" (String.fromFloat ((w - configwidth*r) / 2) ++ "px")
                    , Html.Attributes.style "top" (String.fromFloat ((h - configheight*r) / 2) ++ "px")
                    , Html.Attributes.style "transform-origin" "0 0"
                    , Html.Attributes.style "transform" ("scale(" ++ String.fromFloat r ++ ")")
                ]
                [viewDemonstrate model]
        
viewDemonstrate : Model -> Html Msg
viewDemonstrate model=  
    if model.wholeCounter>1 then
        div[class "menu-contain"]
        [
            div [class "grid-col"] 
                [ 
                    div[class "left-soldier"]
                        [
                            div [class "contain"]
                            [ h1[][text "Civilization Restart"]
                            , ul[class "navcard"]
                            [ li[class "navcard-item"][a[href "#" , onClick <| PageChange Game][text "Start"]]
                            , li[class "navcard-item"][a[href "#" , onClick <| PageChange Help][text "Help"]]
                            , li[class "navcard-item"][a[href "#" , onClick <| PageChange Story][text "Background"]]
                            , li[class "navcard-item"][a[href "#" , onClick <| PageChange About][text "About"]]
                            ]]
                        ]
                ]
            ,div [style "width" "50%"
                    ,style "padding" "2em" 
                    ,style "height" "100%"
                    ,style "box-sizing" "border-box"
                    ,style "float" "left"]
                [   Html.video
                    [
                     style "width" "400px"
                    ,style "height" "400px"
                    ,style "margin-top" "300px"
                    ,src "./video/CG1.mp4"
                    , autoplay True
                    ,controls True
                    ,loop True
                    ][]]
        ]
    else
        div[][]