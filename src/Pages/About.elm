module Pages.About exposing (aboutView)
import Html exposing (Html, div, h1,h2,h3,text, ul, li,p,a,canvas, img,progress,button)
import Html.Attributes exposing (style,class,href,id,disabled,src,width,height)
import Html.Events exposing (onClick)
import Html.Events.Extra.Mouse as Mouse
import Svg 
import Svg.Attributes 
import Model exposing (Model)
import Messages exposing (Msg(..),PageMsg(..))
-- import 

aboutView : Model -> Html Msg
aboutView model =
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
                div[style "margin-left" "43%",style "margin-right" "20%"][h1[style "color" "white"][text "About Us"]],
                div[style "margin-left" "5%",style "float" "left"][img[src "./images/Logo.png",width 500,height 300][]],
                div[style "float" "right",style "margin-right" "25%",style "margin-top" "2%"][div[][h2[style "color" "white"][text "Team: GEAR"]],
                div[][h2[style "color" "white"][text "Member:"]],
                div[][p[style "color" "white"][text "  1)    Zihao Wei"]],
                div[][p[style "color" "white"][text "  2)    Yidong Huang"]], 
                div[][p[style "color" "white"][text "  3)    Qifei Wu"]], 
                div[][p[style "color" "white"][text "  4)    Siyuan Lin"]]],    
                button[class "btn btn-primary btn-ghost btn-shine",style "margin-left" "43%",style "width" "14%", onClick <| PageChange Welcome][text "Back to Menu" ]
            ]
            ]