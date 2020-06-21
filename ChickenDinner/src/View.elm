module View exposing (..)
import Model exposing (..)
import Update exposing (..)
import Messages exposing (Msg(..))
-- import Json.Encode

import Css exposing (..)
-- import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src,autoplay,loop)
import Html.Styled.Events exposing (onClick)

import Svg exposing (..)
import Svg.Styled exposing (..)
import Svg.Styled.Attributes exposing (..)
import Svg.Attributes exposing (d)

view : Model -> Html Msg
view model =
    playerDemonstrate model

playerDemonstrate : Model -> Html msg
playerDemonstrate model =
    let
        gWidth = "1000"
        gHeight = "1000"
        -- meTemp = model.myself
    in
        -- Html.Styled.div[Html.Styled.Attributes.style "background-color" "yellow"][
        Html.Styled.div [Html.Styled.Attributes.style "margin" "20%", Html.Styled.Attributes.style "border-color" "black",
                        Html.Styled.Attributes.style "border-width" "15px",
                        Html.Styled.Attributes.style "border-style" "solid"]
            [ Svg.Styled.svg [Svg.Styled.Attributes.viewBox <| "0 0 " ++ gWidth ++ " " ++ gHeight]
              (List.append  (walls model.viewbox) [me model.myself])
            ]



walls : List Rectangle -> List (Svg.Styled.Svg msg)
walls obstacle =
    let
        createBricksFormat model =
           Svg.Styled.rect 
                [ x <| String.fromFloat model.x
                , y <| String.fromFloat model.y
                , Svg.Styled.Attributes.width <| String.fromFloat model.width
                , Svg.Styled.Attributes.height <| String.fromFloat model.height
                , Svg.Styled.Attributes.fill "black"
                ]
           []
    in
        List.map createBricksFormat obstacle



players : List Player -> List ( Svg.Styled.Svg msg) 
players others =
    let 
        createOpponentsFormat model =
        --"#002c5a"
          Svg.Styled.circle [Svg.Styled.Attributes.fill "red", cx <| String.fromFloat model.x, cy <| String.fromFloat model.y, r <| String.fromFloat model.r][]
    in
        List.map createOpponentsFormat others

me : Me -> Svg.Styled.Svg msg
me  myself=
   let 
        createBallFormat model =
          Svg.Styled.circle [Svg.Styled.Attributes.fill "green", cx "500", cy "500", r <| String.fromFloat model.r][]
    in
        createBallFormat myself