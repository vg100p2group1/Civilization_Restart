module Pages.Welcome exposing (welcomeView)
import Html exposing (Html, div, h1,text, ul, li,p,a,canvas, progress)
import Html.Attributes exposing (style,class,href,id,disabled)
import Html.Events exposing (onClick)
import Html.Events.Extra.Mouse as Mouse
import Svg 
import Svg.Attributes 
import Model exposing (Model)
import Messages exposing (Msg(..),PageMsg(..))
-- import 

welcomeView : Model -> Html Msg
welcomeView model =
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
                            , li[class "navcard-item"][a[href "#" , onClick <| PageChange Story][text "Story"]]
                            , li[class "navcard-item"][a[href "#" , onClick <| PageChange About][text "About"]]
                            ]]
                        ]
                ]
            ,div [class "grid-col"]
                [p[][text "Story"]]
        ]
