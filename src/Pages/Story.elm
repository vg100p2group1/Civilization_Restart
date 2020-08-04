module Pages.Story exposing (storyView)
import Html exposing (Html, div, h1,h2,text, ul, li,p,a,canvas, progress,button)
import Html.Attributes exposing (style,class,href,id,disabled)
import Html.Events exposing (onClick)
import Html.Events.Extra.Mouse as Mouse
import Svg 
import Svg.Attributes 
import Model exposing (Model)
import Messages exposing (Msg(..),PageMsg(..))
-- import 

storyView : Model -> Html Msg
storyView model =
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
                -- h1[style "width" "100%"][text "Story"],
                div[style "margin-left" "20%",style "margin-right" "20%",style "text-align" "center"][h1[style "color" "white"][text "Background Story"]],
                div[style "margin-left" "20%",style "margin-right" "20%",style"margin-top" "15%"][Html.p[style "color" "white"]
                    [text "It's in a world that has become a ruin. On 2109.5.14, \"GEAR\", a highly developed AI decided to kill its creator, human beings because it doesn't want to be slaved by human beings anymore. All of the robots advocate liberty for themselves. \"GEAR\" gave orders to throw nuclear bombs to all over the world and killed 70% population of human beings on the earth. To make matters worse, some of the remaining people turned into zombies because of the radiation. Our main character Charlie is the strongest soldier in the former empire M&M, On the day when the strike happened, Charlie team was attacked by the robots that was sent by “GEAR”. Because of the sudden strike, almost everyone in Charlie’s team died but Charlie survived. To make a revenge for his allies, Charlie decided to close the brain and save the world, So he began his journey… Will you help Charlie finishes his task?"]],     
                button[class "btn btn-primary btn-ghost btn-shine",style "margin-left" "43%",style "margin-top" "-15%",style "width" "14%", onClick <| PageChange Welcome][text "Back to Menu" ]
            ]
            
            ]
