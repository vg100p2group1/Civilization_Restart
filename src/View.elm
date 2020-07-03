module View exposing (view)
import Model exposing (Model, Room, Me, Bullet,Rectangle,Map)
import MapGenerator exposing (roomConfig)
-- import Update exposing (..)
import Messages exposing (Msg(..))
-- import Json.Encode

-- import Config exposing (decoder)

-- import Css exposing (..)
import Html
-- import Html.Styled 
import Html.Attributes 

import Html.Events.Extra.Mouse as Mouse

import Svg 
import Svg.Attributes 



view : Model -> Html.Html Msg
view model =
    playerDemonstrate model

playerDemonstrate : Model -> Html.Html Msg
playerDemonstrate model =
    let
        gWidth = "5000"
        gHeight = "5000"

        -- getMap =
        --     if model.map then
        --         showmap model
        --     else
        --         Html.div[][]
        -- meTemp = model.myself
        rooms = Tuple.first model.rooms
    in
        -- Html.div[Html.Attributes.style "margin" "auto 0"][
        Html.div[][Html.div [Html.Attributes.style "width" "50%",Html.Attributes.style "height" "50%",Html.Attributes.style "float" "left"]
            [ Svg.svg [Mouse.onMove(.clientPos>>MouseMove),Mouse.onDown(\event->MouseDown),Mouse.onUp(\event->MouseUp),Svg.Attributes.width "1000", Svg.Attributes.height "1000",Svg.Attributes.viewBox <| "0 0 " ++ gWidth ++ " " ++ gHeight]
              ( showBullets model.bulletViewbox ++  showMap model.viewbox++ [gun model.myself,me model.myself])]]
            
            --,Html.div[Html.Attributes.style "float" "right"][scoreboard model.myself model.other,getMap]]
        -- ]







showMap : Map -> List (Svg.Svg Msg)

showMap model =
    let
       walls = displayRec model.walls
       roads = displayRec model.roads

       doors = displayDoors model.doors
       obstacles = displayRec model.obstacles
    in
       walls ++ roads ++ doors ++ obstacles

-- mapMe : Me -> Svg.Svg Msg
-- mapMe  myself=
--    let 
--         createBallFormat model =
--           Svg.circle [Svg.Attributes.fill "green", Svg.Attributes.cx <| String.fromFloat myself.x, Svg.Attributes.cy <| String.fromFloat myself.y, Svg.Attributes.r "20"][]
--     in
--         createBallFormat myself


-- scoreboard : Me -> List Player -> Html.Html Msg
-- scoreboard myself allPlayers =
--     let
--         ltemp =  List.map (\value -> {name=value.name,score=value.score}) allPlayers ++ [{name=myself.name,score=myself.score}]
--         scoretemp = List.sortWith flippedComparison ltemp
--         flippedComparison a b =
--             case compare a.score b.score of
--             LT -> GT
--             EQ -> EQ
--             GT -> LT

--         scoreRank = List.map (\value -> Html.div[][Html.text (value.name ++ "  " ++String.fromFloat value.score)]) scoretemp
--     in
--         Html.div[]scoreRank



displayRec : List Rectangle -> List (Svg.Svg Msg)
displayRec obstacle =
    let
        
        -- d=Debug.log "wall" obstacle
        createBricksFormat model =
           Svg.rect 
                [ Svg.Attributes.x <| String.fromFloat model.x
                , Svg.Attributes.y <| String.fromFloat model.y
                , Svg.Attributes.width <| String.fromFloat model.width
                , Svg.Attributes.height <| String.fromFloat model.height
                , Svg.Attributes.fill "black"
                ]
           []
    in
        List.map createBricksFormat obstacle


displayDoors : List Rectangle -> List (Svg.Svg Msg)
displayDoors obstacle =
    let
        
        -- d=Debug.log "wall" obstacle
        createBricksFormat model =
           Svg.rect 
                [ Svg.Attributes.x <| String.fromFloat model.x
                , Svg.Attributes.y <| String.fromFloat model.y
                , Svg.Attributes.width <| String.fromFloat model.width
                , Svg.Attributes.height <| String.fromFloat model.height
                , Svg.Attributes.fill "grey"
                ]
           []
    in
        List.map createBricksFormat obstacle



-- players : Me -> List Player -> List ( Svg.Svg Msg) 
-- players myself others =
--     let 
    
--         createOpponentsFormat model =
--           if not model.die then         
--             Svg.circle [Svg.Attributes.fill "red", Svg.Attributes.cx <| String.fromFloat (model.x-myself.x+500), Svg.Attributes.cy <| String.fromFloat (model.y-myself.y+500), Svg.Attributes.r <| String.fromFloat model.r][]
--           else  
--             Svg.rect 
--                 [ Svg.Attributes.x <| String.fromFloat (model.x-myself.x+500-model.r)
--                 , Svg.Attributes.y <| String.fromFloat (model.y-myself.y+500-model.r)
--                 , Svg.Attributes.width <| String.fromFloat (model.r*2)
--                 , Svg.Attributes.height <| String.fromFloat (model.r*2)
--                 , Svg.Attributes.fill "grey"
--                 ][]
--                 -- [Svg.Attributes.fill "red", Svg.Attributes.cx <| String.fromFloat (model.x-myself.x+500), Svg.Attributes.cy <| String.fromFloat (model.y-myself.y+500), Svg.Attributes.r <| String.fromFloat model.r][]  
--     in
--         List.map createOpponentsFormat others

me : Me -> Svg.Svg Msg
me  myself=
   let 
        createBallFormat model =
          Svg.circle [Svg.Attributes.fill "green", Svg.Attributes.cx "500", Svg.Attributes.cy "500", Svg.Attributes.r <| String.fromFloat model.r][]
    in
        createBallFormat myself

gun : Me -> Svg.Svg Msg
gun myself =
    let       
        pos = myself.mouseData
        px = Tuple.first pos
        py = Tuple.second pos
        -- d1 =Debug.log "px" px
        -- d2 = Debug.log "p2" py
        route=Svg.Attributes.d(
                                      " M 500 500" ++
                                      " L " ++ String.fromFloat px ++ " " ++ String.fromFloat py
                                      )
        getcolor = 
            if myself.fire then 
                "red"
            else
                "blue"                              
        -- transformAnimation = Svg.Styled.animateTransform[ Svg.Styled.Attributes.attributeName "transform", Svg.Styled.Attributes.begin "0s", Svg.Styled.Attributes.dur "3s", type_ "scale", from "1", to "1.2", repeatCount "indefinite"][]
    in
        Svg.path [ route ,  Svg.Attributes.stroke getcolor, Svg.Attributes.strokeWidth "2"][]


showBullets : List Bullet -> List ( Svg.Svg Msg) 
showBullets bullets =
    let 
        createBulletFormat model =
        --"#002c5a"
          Svg.circle [Svg.Attributes.fill "gray", Svg.Attributes.cx <| String.fromFloat  model.x, Svg.Attributes.cy <| String.fromFloat  model.y, Svg.Attributes.r <| String.fromFloat model.r][]
    in
        List.map createBulletFormat bullets