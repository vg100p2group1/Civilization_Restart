module View exposing (view)
import Model exposing (Model,Me,Dialogues,State(..), Side(..))
import Map.Map exposing (Map,Monster,Room)
import Weapon exposing (Bullet)
import Shape exposing (Rectangle)
import Messages exposing (Msg(..))
import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import Config exposing (sentenceInit)


import Html.Events.Extra.Mouse as Mouse

import Svg 
import Svg.Attributes 



view : Model -> Html.Html Msg
view model =
    playerDemonstrate model

playerDemonstrate : Model -> Html.Html Msg
playerDemonstrate model =
    let
        gWidth = "10000"
        gHeight = "10000"
    in
        Html.div[][Html.div [Html.Attributes.style "width" "50%",Html.Attributes.style "height" "50%",Html.Attributes.style "float" "left"]
            [ Svg.svg [Mouse.onMove(.clientPos>>MouseMove),Mouse.onDown(\event->MouseDown),Mouse.onUp(\event->MouseUp),Svg.Attributes.width "1000", Svg.Attributes.height "1000",Svg.Attributes.viewBox <| "0 0 " ++ gWidth ++ " " ++ gHeight]
              ( showBullets model.bulletViewbox ++  showMap model.viewbox++ [gun model.myself,me model.myself])], showDialogue model 0]


showMap : Map -> List (Svg.Svg Msg)

showMap model =
    let
       walls = displayRec model.walls
       roads = displayRec model.roads

       doors = displayDoors model.doors
       obstacles = displayRec model.obstacles
       monsters = displayMonster model.monsters
       gate = displayDoors [model.gate]
    --    d = Debug.log "gateshow" model.gate
    in
       walls ++ roads ++ doors ++ obstacles ++ monsters ++ gate
    --    walls++gate



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

displayMonster : List Monster -> List (Svg.Svg Msg)
displayMonster monsters =
    let
        -- d=Debug.log "wall" obstacle
        createMonsterFormat monsterTemp =
            let
                model = monsterTemp.position
                monsterType = monsterTemp.monsterType
            in
                Svg.circle
                    [ Svg.Attributes.cx <| String.fromFloat model.cx
                    , Svg.Attributes.cy <| String.fromFloat model.cy
                    , Svg.Attributes.r <| String.fromFloat model.r
                    , Svg.Attributes.fill monsterType.color
                    ]
                []
    in
        List.map createMonsterFormat monsters


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
        route=Svg.Attributes.d(
                                      " M 500 500" ++
                                      " L " ++ String.fromFloat px ++ " " ++ String.fromFloat py
                                      )
        getcolor = 
            if myself.fire then 
                "red"
            else
                "blue"                              
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



showDialogue : Model -> Float -> Html Msg
showDialogue model deltaTime =
    case model.state of
        Dialogue ->
            let
                txt = Maybe.withDefault sentenceInit (List.head model.currentDialogues)
                location =
                    case txt.side of
                        Left -> "120px 0 0 -50px"
                        Right -> "120px 0 0 390px"
                        Bottom -> "300px 0 0 120px"
            in
                div
                [ style "background" "rgba(236, 240, 241, 0.89)"
                , style "color" "#34495f"
                , style "height" "400px"
                , style "left" "280px"
                , style "padding" "0 140px"
                , style "position" "absolute"
                , style "top" "155px"
                , style "width" "400px"
                , style "background-image" txt.image
                , style "background-size" "100% 100%"
                ]
                [ div [style "margin" "20px 0 0 120px", style "color" "red"] [text "Press ENTER to continue"]
                , div
                    [ style "margin" location
                    , style "position" "absolute"
                    , style "color" "orange"
                    ]
                    [text txt.text]
                ]
        _ ->
            div [] []




