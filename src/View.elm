module View exposing (view)
import Model exposing (Model,Me,Dialogues,State(..), Side(..), sentenceInit)
import Map.Map exposing (Map,Monster,Room)
import Weapon exposing (Bullet)
import Shape exposing (Rectangle)
import Messages exposing (Msg(..))
import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import Html.Events.Extra.Mouse as Mouse
import Svg 
import Svg.Attributes 

import MiniMap exposing (getMiniMap)


-- view : Model -> Html.Html Msg
-- view model =
--     playerDemonstrate model


view : Model -> Html.Html Msg
view model =
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
            [ Html.Attributes.style "width" "100%"
            , Html.Attributes.style "height" "100%"
            , Html.Attributes.style "position" "absolute"
            , Html.Attributes.style "left" "0"
            , Html.Attributes.style "top" "0"
            , Html.Attributes.style "background" "linear-gradient(135deg, rgba(206,188,155,1) 0%, rgba(85,63,50,1) 51%, rgba(42,31,25,1) 100%)"
            , Html.Attributes.style "overflow" "scroll"
            , Html.Attributes.style "overflow-x" "hidden"
            ]

            [ Html.div

                [ Html.Attributes.style "top" "200px"
                , Html.Attributes.style "left" "200px"
                ]
                [showMiniMap model]

            , Html.div
                [ 
                    Html.Attributes.style "width" (String.fromFloat configwidth ++ "px")
                    , Html.Attributes.style "height" (String.fromFloat configheight ++ "px")
                    , Html.Attributes.style "position" "absolute"
                    , Html.Attributes.style "left" (String.fromFloat ((w - configwidth*r) / 2) ++ "px")
                    , Html.Attributes.style "top" (String.fromFloat ((h - configheight*r) / 2) ++ "px")
                    , Html.Attributes.style "transform-origin" "0 0"
                    , Html.Attributes.style "transform" ("scale(" ++ String.fromFloat r ++ ")")
                ]
                [playerDemonstrate model]
            ]


playerDemonstrate : Model -> Html.Html Msg
playerDemonstrate model =
    let
        gWidth = "1000"
        gHeight = "1000"
    in
        Html.div
        []
        [ Html.div 
            [ Html.Attributes.style "width" "100%"
            , Html.Attributes.style "height" "100%"
            , Html.Attributes.style "float" "left"
            , Html.Attributes.style "border" "outset"
            ]
            [ Svg.svg 
                [ Mouse.onMove(.clientPos>>MouseMove)
                , Mouse.onDown(\event->MouseDown)
                , Mouse.onUp(\event->MouseUp)
                , Svg.Attributes.width "1000"
                , Svg.Attributes.height "1000"
                , Svg.Attributes.viewBox <| "0 0 " ++ gWidth ++ " " ++ gHeight
                ]
              ( showBullets model.bulletViewbox ++ showMap model.viewbox ++ [gun model.myself, me model.myself])
            ]
            , showDialogue model 0
        ]



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
        createBricksFormat monsterTemp =
            let
                model = monsterTemp.position
                monsterType = monsterTemp.monsterType
                opacity = String.fromFloat (monsterTemp.monsterType.hp / 150)

                monsterColor = if monsterTemp.active then "black" else monsterType.color
            in
                Svg.circle
                    [ Svg.Attributes.cx <| String.fromFloat model.cx
                    , Svg.Attributes.cy <| String.fromFloat model.cy
                    , Svg.Attributes.r <| String.fromFloat model.r
                    , Svg.Attributes.fill monsterColor
                    , Svg.Attributes.fillOpacity opacity
                    ]
                []
    in
        List.map createBricksFormat monsters


me : Me -> Svg.Svg Msg
me myself=
    Svg.image [Svg.Attributes.x "460", Svg.Attributes.y "460", Svg.Attributes.xlinkHref myself.url, Svg.Attributes.preserveAspectRatio "none meet", 
                   Svg.Attributes.width "80", Svg.Attributes.height "80"][]

gun : Me -> Svg.Svg Msg
gun myself =
    let       
        pos = myself.mouseData
        px = Tuple.first pos
        py = Tuple.second pos
        route=Svg.Attributes.d(" M 500 500" ++
                               " L " ++ String.fromFloat px ++ " " ++ String.fromFloat py
                              )
        getcolor = 
            if myself.fire then 
                "red"
            else
                "blue"                              
    in
        Svg.path [route , Svg.Attributes.stroke getcolor, Svg.Attributes.strokeWidth "2"][]


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




showMiniMap : Model -> Html.Html Msg
showMiniMap model =
    let
       (miniMap,(dx,dy)) =getMiniMap model.map <| Tuple.first model.rooms

       walls = displayRec miniMap.walls
       roads = displayRec miniMap.roads
       gate = displayDoors [miniMap.gate]

       myself = model.myself
       xTemp = myself.x - toFloat(dx*2500)
       yTemp = myself.y - toFloat(dy*2500)
       rTemp = 200

       meTemp= [Svg.circle [Svg.Attributes.fill "green", Svg.Attributes.cx <| String.fromFloat xTemp, Svg.Attributes.cy <| String.fromFloat yTemp, Svg.Attributes.r <| String.fromFloat rTemp][]]
    in
        Svg.svg [Svg.Attributes.width "500", Svg.Attributes.height "500", Svg.Attributes.viewBox <| "-300 -300 15000 15000"]
        (walls ++ roads  ++ gate ++ meTemp)

