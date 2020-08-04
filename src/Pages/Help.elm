module Pages.Help exposing (helpView)
import Html exposing (Html, div, h1,h3,text, ul, li,p,a,canvas, progress,button)
import Html.Attributes exposing (style,class,href,id,disabled)
import Html.Events exposing (onClick)
import Html.Events.Extra.Mouse as Mouse
import Svg 
import Svg.Attributes 
import Model exposing (Model)
import Messages exposing (Msg(..),PageMsg(..))
-- import 

helpView : Model -> Html Msg
helpView model =
        -- div[class "menu-contain"]
        -- [
        --     div [class "grid-col"] 
        --         [ 
        --             div[class "left-soldier"]
        --                 [
        --                     div [class "contain"]
        --                     [ h1[][text "Civilization Restart"]
        --                     , ul[class "navcard"]
        --                     [ li[class "navcard-item"][a[href "#" , onClick <| PageChange Game][text "Start"]]
        --                     , li[class "navcard-item"][a[href "#" , onClick <| PageChange Help][text "Help"]]
        --                     , li[class "navcard-item"][a[href "#" , onClick <| PageChange Story][text "Story"]]
        --                     , li[class "navcard-item"][a[href "#" , onClick <| PageChange About][text "About"]]
        --                     ]]
        --                 ]
        --         ]
        --     ,div [class "grid-col"]
        --         [p[][text "Story"]]
        -- ]
        div[    
            style "overflow" "scroll",
            style "margin" "0 auto",
            style "overflow-x" "hidden",
            style "overflow-y" "hidden"]
            [div[                
            style "border-color" "silver",
            style "border-width" "15px",
            style "border-style" "outset",
            style "margin" "0 auto",
            style "width" "1000px",
            style "height" "600px",
            style "background" "linear-gradient(135deg, rgba(206,188,155,1) 0%, rgba(85,63,50,1) 51%, rgba(42,31,25,1) 100%)"]
            [
                div[style "margin-left" "20%",style "margin-right" "20%",style "text-align" "center"][h1[style "color" "white"][text "How to Play"]],
                div[style "margin-left" "20%",style "margin-right" "20%"][h3[style "color" "white"][text "1)	WASD for moving Up,Left,Down and Right."]],
                div[style "margin-left" "20%",style "margin-right" "20%"][h3[style "color" "white"][text "2) 	When getting near the gate, press F to move into the next floor."]],
                -- div[style "margin-left" "20%",style "margin-right" "20%"][h3[style "color" "white"][text "3)    G  to open the test window for Dialogs.  Enter for the next sentence. "]],
                div[style "margin-left" "20%",style "margin-right" "20%"][h3[style "color" "white"][text "3)    Moving the mouse to aim & Left-Click  to Shoot."]],
                div[style "margin-left" "20%",style "margin-right" "20%"][h3[style "color" "white"][text "4)	Press Q and E to shift Guns.	"]],
                div[style "margin-left" "20%",style "margin-right" "20%"][h3[style "color" "white"][text "5)    Press B To open the skill window and press B again to close the window."]],
                div[style "margin-left" "20%",style "margin-right" "20%"][h3[style "color" "white"][text "6)    Press R to open the synthesis window."]],
                div[style "margin-left" "20%",style "margin-right" "20%"][h3[style "color" "white"][text "7)    Press 1，2，3，4，5 to use active skills."]],
                div[style "margin-left" "20%",style "margin-right" "20%"][h3[style "color" "white"][text "8)    Press F to pick the treasure."]],      
                button[class "btn btn-primary btn-ghost btn-shine",style "margin-left" "43%",style "width" "14%",onClick <| PageChange Welcome][text "Back to Menu" ]
            ]
            
            ]