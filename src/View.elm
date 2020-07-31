module View exposing (view)
import Model exposing (Model,Me,Dialogues,State(..), Side(..), sentenceInit)
import Map.Map exposing (Map,Monster,Room,Treasure,Door,Boss)
import Weapon exposing (Bullet)
import Skill exposing (getCurrentSubSystem, Skill, unlockChosen)
import Shape exposing (Rectangle,recCollisionTest,Rec,circleRecTest,recUpdate)
import Messages exposing (Msg(..), SkillMsg(..))
import Attributes exposing (Attr, AttrType(..), getCurrentAttr, getMaxAttr, getAttrName)
import Html exposing (Html, div, text, button, progress)
import Html.Attributes exposing (style, disabled)
import Html.Events exposing (onClick)
import Html.Events.Extra.Mouse as Mouse
import Svg 
import Svg.Attributes 

import MiniMap exposing (getMiniMap)
import Animation.ShowGun exposing (showGun)
import Animation.Explosion exposing (showExplosion)
import Animation.ShowBullet exposing (showBullets)
import Environment.ShowWalls exposing (showWalls)
import Config exposing (bulletSpeed)
import Environment.ShowFloor exposing (showFloor)
import Environment.ShowObstacle exposing (showObstacle)
-- view : Model -> Html.Html Msg
-- view model =
--     playerDemonstrate model
import Synthesis.ShowSynthesis exposing (showSynthesis)
import Display.DisplaySkill exposing (showSkill)
import Display.Define exposing (defines)
import Environment.ShowFloor exposing(showFloor)
import Environment.ShowObstacle exposing (showObstacle)

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

                [ Html.Attributes.style "top" "0px"
                , Html.Attributes.style "left" "0px"
                , Html.Attributes.style "width" (String.fromFloat (500*r) ++ "px")
                , Html.Attributes.style "height" (String.fromFloat (500*r) ++ "px")
                -- , Html.Attributes.style "transform" ("scale(" ++ String.fromFloat r ++ ")")
                ]
                [showMiniMap model r] 
            
            , Html.div
                [ style "right" "0px"
                , style "top" "0px"
                , style "position" "absolute"
                , Html.Attributes.style "transform-origin" "100% 0 0"
                , Html.Attributes.style "transform" ("scale(" ++ String.fromFloat r ++ ")")
                ]
                [showAttr model.myself.attr r]

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
            [Svg.svg 
                [ Mouse.onMove(.clientPos>>MouseMove)
                , Mouse.onDown(\event->MouseDown)
                , Mouse.onUp(\event->MouseUp)
                , Svg.Attributes.width "1000"
                , Svg.Attributes.height "1000"
                , Svg.Attributes.viewBox <| "0 0 " ++ gWidth ++ " " ++ gHeight
                ]
              ([defines]++ showFloor model ++ showBullets model.bulletViewbox ++ showMap model.viewbox ++ [me model.myself] ++ [showGun model.myself]  ++ showExplosion model.explosionViewbox)
            ]
            , showDialogue model 0
            , showSkill model
            , showSynthesis model
            , showGameOver model
        ]



showMap : Map -> List (Svg.Svg Msg)
showMap model =
    let
       walls = showWalls <| List.filter (\value-> recCollisionTest  (Rec 0 0 1000 1000) (.edge (recUpdate value.position))) model.walls
    --    d2=Debug.log "walls List" model.walls
    --    d1=Debug.log "walls" <| List.filter (\value-> recCollisionTest  (Rec 0 0 1000 1000) (.edge (recUpdate value))) model.walls
       
       roads = displayRec <| List.filter (\value-> recCollisionTest  (Rec 0 0 1000 1000) (.edge (recUpdate value))) model.roads

       doors = displayDoors <| List.filter (\value-> recCollisionTest  (Rec 0 0 1000 1000) (.edge  (recUpdate value.position))) model.doors
       obstacles = showObstacle  <| List.filter (\value-> recCollisionTest  (Rec 0 0 1000 1000) (.edge (recUpdate value)))  model.obstacles
       monsters = displayMonster <| List.filter (\value-> circleRecTest value.position  (Rec 0 0 1000 1000) ) model.monsters

       treasure = displayTreasure  model.treasure
       boss = displayBoss  model.boss

       gate = displayDoors [Door model.gate False] -- To
    --    d = Debug.log "gateshow" model.gate
    in
       walls ++ roads ++ doors ++ obstacles ++ monsters ++ gate ++ treasure ++ boss
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


displayDoors : List Door -> List (Svg.Svg Msg)
displayDoors doors =
    let
        
        -- d=Debug.log "wall" obstacle
        createBricksFormat door =
            let
                color =
                    if door.enable then
                        "black"
                    else
                        "grey"
                model = door.position
            in 
                Svg.rect 
                        [ Svg.Attributes.x <| String.fromFloat model.x
                        , Svg.Attributes.y <| String.fromFloat model.y
                        , Svg.Attributes.width <| String.fromFloat model.width
                        , Svg.Attributes.height <| String.fromFloat model.height
                        , Svg.Attributes.fill color
                        ]
                []
    in
        List.map createBricksFormat doors


displayMonster : List Monster -> List (Svg.Svg Msg)
displayMonster monsters =
    let
        -- d=Debug.log "wall" obstacle
        createBricksFormat monsterTemp =
            let
                model = monsterTemp.position
                monsterType = monsterTemp.monsterType
                opacity = String.fromFloat (monsterTemp.monsterType.hp / 150)
                -- d1=Debug.log "face" monsterTemp.face
                getUrl =
                    if monsterTemp.face then
                       monsterType.url
                    else 
                       monsterType.url++"L"
                -- monsterColor = if monsterTemp.active then "black" else monsterType.color
            in
                Svg.use
                    [ Svg.Attributes.x <| String.fromFloat (model.cx-model.r)
                    , Svg.Attributes.y <| String.fromFloat (model.cy-model.r)
                    , Svg.Attributes.xlinkHref getUrl
                    -- , Svg.Attributes.r<| String.fromFloat model.r
                    -- , Svg.Attributes.fill monsterColor
                    , Svg.Attributes.fillOpacity opacity
                    ]
                []
    in
        List.map createBricksFormat monsters


displayBoss : List Boss  -> List (Svg.Svg Msg)
displayBoss boss =
    let
        -- d=Debug.log "wall" obstacle
        createBricksFormat bossTemp =
            let
                model = bossTemp.position
                bossType = bossTemp.bossType
                opacity = String.fromFloat (bossType.hp / 500)
                

                bossColor =bossType.color
            in
                
                Svg.rect
                    [ Svg.Attributes.x <| String.fromFloat model.x
                    , Svg.Attributes.y <| String.fromFloat model.y
                    , Svg.Attributes.width <| String.fromFloat model.width
                    , Svg.Attributes.height <| String.fromFloat model.height
                    , Svg.Attributes.fill bossColor
                    , Svg.Attributes.fillOpacity opacity
                
                    ]
                []
    in
         List.map createBricksFormat boss
displayTreasure : List Treasure  -> List (Svg.Svg Msg)
displayTreasure treasure =
    let
        -- d=Debug.log "wall" obstacle
        createBricksFormat treasureTemp =
            let
                model = treasureTemp.position
                treasureType = treasureTemp.treasureType
                

                treasureColor = treasureType.color
            in
                if not treasureTemp.canShow  then 
                Svg.rect
                    [ Svg.Attributes.x <| String.fromFloat model.x
                    , Svg.Attributes.y <| String.fromFloat model.y
                    , Svg.Attributes.width <| String.fromFloat 0
                    , Svg.Attributes.height <| String.fromFloat 0
                    , Svg.Attributes.fill treasureColor
                
                    ]
                []
                else
                Svg.rect
                    [ Svg.Attributes.x <| String.fromFloat model.x
                    , Svg.Attributes.y <| String.fromFloat model.y
                    , Svg.Attributes.width <| String.fromFloat model.width
                    , Svg.Attributes.height <| String.fromFloat model.height
                    , Svg.Attributes.fill treasureColor
                
                    ]
                []
    in
        List.map createBricksFormat treasure


me : Me -> Svg.Svg Msg
me myself=
    Svg.use [Svg.Attributes.x "480", Svg.Attributes.y "480", Svg.Attributes.xlinkHref myself.url, 
                   Svg.Attributes.width "40", Svg.Attributes.height "40"][]

-- gun : Me -> Svg.Svg Msg
-- gun myself =
--     let       
--         pos = myself.mouseData
--         px = Tuple.first pos
--         py = Tuple.second pos
--         route=Svg.Attributes.d(" M 500 520" ++
--                                " L " ++ String.fromFloat px ++ " " ++ String.fromFloat py
--                               )
--         getcolor = 
--             if myself.fire then 
--                 "red"
--             else
--                 myself.currentWeapon.color
--     in
--         Svg.path [route , Svg.Attributes.stroke getcolor, Svg.Attributes.strokeWidth "2"][]






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





showGameOver : Model -> Html Msg
showGameOver model =
    if model.isGameOver then
        div
            [ style "background" "rgba(236, 240, 241, 0.89)"
            , style "color" "#34495f"
            , style "height" "400px"
            , style "left" "280px"
            , style "padding" "0 140px"
            , style "position" "absolute"
            , style "top" "155px"
            , style "width" "400px"
            ]
            [ div [style "margin" "160px 0 0 135px", style "color" "red",style "font-size" "24px"] [text "Game Over"]
            ]
    else
        div [] []

showMiniMap : Model -> Float -> Html.Html Msg
showMiniMap model r=
    let
       (miniMap,(dx,dy)) =getMiniMap model.map <| Tuple.first model.rooms
       

       wallPosUpdate value=
            let 
                rectangle = value.position
            in 
                -- if rectangle.width>rectangle.height && rectangle.width>1000  then
                --     {rectangle|x=rectangle.x-200,width=rectangle.width+400}
                -- else     
                    rectangle 

       walls = displayRec <| List.map wallPosUpdate miniMap.walls
       roads = displayRec miniMap.roads
       gate = displayDoors [Door miniMap.gate False]

       myself = model.myself
       xTemp = myself.x - toFloat(dx*2500)
       yTemp = myself.y - toFloat(dy*2500)
       rTemp = 200

       widthConfig = 500*r
       meTemp= [Svg.circle [Svg.Attributes.fill "green", Svg.Attributes.cx <| String.fromFloat xTemp, Svg.Attributes.cy <| String.fromFloat yTemp, Svg.Attributes.r <| String.fromFloat rTemp][]]
    in
        Svg.svg [Svg.Attributes.width <| (String.fromFloat widthConfig)++"px", Svg.Attributes.height  <| (String.fromFloat widthConfig)++"px", Svg.Attributes.viewBox <| "-300 -300 15000 15000"]
        (walls ++ roads  ++ gate ++ meTemp)

showAttr : Attr -> Float -> Html Msg
showAttr attr r= 
    div
    [ 
        -- style "padding" "0 140px"
    -- , style "position" "absolute"
        -- style "hight" "500px"
    ]
    (List.map (makeProgress attr r) [Health, Clip, Armor, Attack, Speed, ShootSpeed])

makeProgress : Attr -> Float -> AttrType -> Html Msg
makeProgress attr r t =
    let
        maxAttr = String.fromFloat <| (toFloat <| getMaxAttr t attr) * r
        valueAttr = String.fromFloat <| (toFloat <| getCurrentAttr t attr) * r
    in
    div 
    [style "margin" "20px"]
    [ div
        [style "width" "50px", style "font-size" "10px"]
        [text (getAttrName t ++ ":")]
    , progress
        [ Html.Attributes.max maxAttr
        , Html.Attributes.value valueAttr
        ]
        [text (valueAttr ++ "/" ++ maxAttr)]
    ]