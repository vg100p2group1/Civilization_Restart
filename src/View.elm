module View exposing (view)
import Model exposing (Model,Me,Dialogues,State(..), Side(..), sentenceInit,Page(..))
import Map.Map exposing (Map,Monster,Room,Treasure,Door,Boss)
import Weapon exposing (Bullet)
import Skill exposing (getCurrentSubSystem, Skill, unlockChosen)
import Shape exposing (Rectangle,recCollisionTest,Rec,circleRecTest,recUpdate)
import Messages exposing (Msg(..), SkillMsg(..),PageMsg(..))
import Attributes exposing (Attr, AttrType(..), getCurrentAttr, getMaxAttr, getAttrName)
import Html exposing (Html, div, text, button, progress,img)
import Html.Attributes exposing (style, disabled,autoplay,src)
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
import Environment.ShowTreasure exposing (displayTreasure)
import Environment.ShowDoor exposing (showDoor)
import Pages.About exposing (aboutView)
import Shape exposing (recInit)
import Display.Cool exposing (showSkillCooling)
-- view model =
--     playerDemonstrate model
import Synthesis.ShowSynthesis exposing (showSynthesis)
import Display.DisplaySkill exposing (showSkill)
import Display.Define exposing (defines)
import Display.DisplayTraining exposing (showTraining)
import Display.DisplayMonsterHp exposing (showMonsterHp)
import Environment.ShowFloor exposing(showFloor)
import Environment.ShowObstacle exposing (showObstacle)
import Environment.ShowTreasure exposing (displayTreasure)
import Environment.ShowGate exposing (showGate)
import Environment.ShowDoor exposing (showDoor)

import Pages.Welcome exposing (welcomeView)
import Pages.About exposing (aboutView)
import Pages.Help exposing (helpView)
import Pages.Story exposing (storyView)
import Environment.ShowRoad exposing (showRoad,showMiddle)
import Display.DisplayChoosingWeapon exposing (showWeaponChoosingSystem)
import Animation.SkillEffect exposing (showSkillEffect,showBackEffect)
import Display.Cool exposing (showSkillCooling)

view : Model -> Html.Html Msg
view model =
    case model.pageState of
        WelcomePage->
            welcomeView model
        AboutPage ->
            aboutView model  
        HelpPage ->
            helpView model  
        StoryPage ->
            storyView model  
        _ ->
            gameView model   

gameView : Model -> Html.Html Msg
gameView model =
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
        
        r3 =
            if w / h > 1 then
                Basics.min 1 (h / 230)

            else
                Basics.min 1 (w / 170)
        rTemp =
            if r<1 then 
             2*r
            else
             r
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

            [ 

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
                [playerDemonstrate model]
            
            , Html.div

                [ 
                  style "background" "rgba(236, 240, 241, 0.3)"
                , style "color" "#34495f"
                , Html.Attributes.style "left" (String.fromFloat ((w - configwidth*r) / 2) ++ "px")
                , Html.Attributes.style "top" (String.fromFloat ((h - configheight*r) / 2) ++ "px")
                , style "position" "absolute"
                , style "padding" "50px"
                , style "width" "550px"
                , style "height" "550px"
                , style "background-size" "100% 100%"
                , Html.Attributes.style "transform-origin" "0% 0%"
                , Html.Attributes.style "transform" ("scale(" ++ String.fromFloat (r*0.5) ++ ")")
                ]
                [showMiniMap model 1] 



            ,Html.div

                [ 
                  style "background" "rgba(236, 240, 241, 0.3)"
                , style "color" "#34495f"
                , Html.Attributes.style "left" (String.fromFloat ((w - configwidth*r) / 2) ++ "px")
                , Html.Attributes.style "bottom" (String.fromFloat ((h - configheight*r) / 2) ++ "px")
                , style "position" "absolute"
                , style "width" "310px"
                , style "height" "70px"
                , style "background-size" "100% 100%"
                , style "padding-top" "10px"
                , style "padding-bottom" "10px"
                , style "padding-left" "10px"
                , Html.Attributes.style "transform-origin" "0% 100%"
                , Html.Attributes.style "transform" ("scale(" ++ String.fromFloat r ++ ")")
                ]
                [showSkillCooling model 1] 
            
            ,Html.div
                [ 
                  style "background" "rgba(236, 240, 241, 0.3)"
                , style "color" "#34495f"
                , Html.Attributes.style "left" (String.fromFloat ((w - configwidth*r) / 2 +(1000-230)*r) ++ "px")
                , Html.Attributes.style "top" (String.fromFloat ((h - configheight*r) / 2) ++ "px")
                , style "position" "absolute"
                , style "width" "230px"
                , style "height" "170px"
                , style "background-size" "100% 100%"
                -- , style "margin-right" <| (String.fromFloat (-20*r3)) ++ "px" 
                -- , style "padding" "10px"
                , Html.Attributes.style "transform-origin" "0% 0%"
                , Html.Attributes.style "transform" ("scale(" ++ String.fromFloat r ++ ")")
                ]
                [showAttr model.myself.attr 1] 
            ]




playerDemonstrate : Model -> Html.Html Msg
playerDemonstrate model =
    let
        gWidth = "1000"
        gHeight = "1000"

        addaudio = model.myself.addAudio

        newAudio = List.map generateaudio addaudio

        generateaudio : String -> Html.Html Msg

        generateaudio instring =
            Html.audio[autoplay True,src instring][]

    in
        Html.div
        []
        ([ Html.div 
            [ Html.Attributes.style "width" "1000"
            , Html.Attributes.style "height" "1000"
            -- , Html.Attributes.style "float" "left"
            -- , Html.Attributes.style "border" "outset"
            ]
            [Svg.svg 
                [ Mouse.onMove(.clientPos>>MouseMove)
                , Mouse.onDown(\event->MouseDown)
                , Mouse.onUp(\event->MouseUp)
                , Svg.Attributes.width "1000"
                , Svg.Attributes.height "1000"
                , Svg.Attributes.viewBox <| "0 0 " ++ gWidth ++ " " ++ gHeight
                ]
              ([defines]++ backgroundEntire model.viewbox ++ showFloor model ++ showBullets model.bulletViewbox ++ showMap model.viewbox ++  showBackEffect model
                ++ [me model.myself] ++ [showGun model.myself]  ++showSkillEffect model ++ showExplosion model.explosionViewbox)
            ]
            , showDialogue model 0
            , showSkill model
            , showSynthesis model
            , showGameOver model
            , showWeaponChoosingSystem model
            , showTraining model
        ]++newAudio++showMonsterHp model.myself model.map.monsters)

backgroundEntire : Map ->  List (Svg.Svg Msg)
backgroundEntire model=
    let
        roads = model.roads
        background = showMiddle roads
        backCanvas = displayRec [Rectangle 0 0 1000 1000 recInit]
    in
        backCanvas ++ background 

showMap : Map -> List (Svg.Svg Msg)
showMap model =
    let
    --    walls = showWalls <| List.filter (\value-> recCollisionTest  (Rec 0 0 1000 1000) (.edge (recUpdate value.position))) model.walls
    --    d2=Debug.log "walls List" model.walls
    --    d1=Debug.log "walls" <| List.filter (\value-> recCollisionTest  (Rec 0 0 1000 1000) (.edge (recUpdate value))) model.walls
       
       --<| List.filter (\value-> recCollisionTest  (Rec 0 0 1000 1000) (.edge (recUpdate value)))
       
       roads = 
            if List.isEmpty (List.filter (\value -> value.enable) model.doors) then
                showRoad model.roads
            else 
                []

       doors = showDoor <| List.filter (\value-> recCollisionTest  (Rec 0 0 1000 1000) (.edge  (recUpdate value.position))) model.doors
       obstacles = showObstacle  <| List.filter (\value-> recCollisionTest  (Rec 0 0 1000 1000) (.edge (recUpdate value)))  model.obstacles
       monsters = displayMonster <| List.filter (\value-> circleRecTest value.position  (Rec 0 0 1000 1000) ) model.monsters

       treasure = displayTreasure  model.treasure
       boss = displayBoss  model.boss

       gate = showGate model.gate -- To
    --    d = Debug.log "gateshow" model.gate
    in
       roads ++ doors  ++ obstacles ++ monsters ++ [gate] ++ treasure ++ boss
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
                        "orange"
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
                

                bossurl =bossType.url
            in
                
                Svg.use
                    [ Svg.Attributes.x <| String.fromFloat model.x
                    , Svg.Attributes.y <| String.fromFloat model.y
                    , Svg.Attributes.xlinkHref bossurl
                    -- , Svg.Attributes.fillOpacity opacity
                
                    ]
                []
    in
         List.map createBricksFormat boss



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
                    if txt.text == "Enjoy the game now!" then
                        "250px 0 0 150px"
                    else
                        "250px 0 0 50px"
                image_ =
                    case model.storey of
                        1 -> "url(images/Dialogue/boss1"
                        3 -> "url(images/Dialogue/boss2"
                        5 -> "url(images/Dialogue/boss3"
                        _ -> "url(images/Dialogue/boss1"
                image = case txt.side of
                            Right -> image_ ++ ".jpg)"
                            _ -> image_ ++ "_" ++ ".jpg)"
            in
                div
                [ style "background-image" image
                --, style "color" "#34495f"
                , style "border-radius" "35px"
                , style "height" "350px"
                , style "left" "200px"
                , style "padding" "0 140px"
                , style "position" "absolute"
                , style "top" "300px"
                , style "width" "700px"
                --, style "background-image" txt.image
                , style "background-size" "100% 100%"
                ]
                [ div [style "margin" "20px 0 0 140px", style "color" "blue"] [text "Press ENTER to continue"]
                , div
                    [ style "margin" location
                    , style "position" "absolute"
                    , style "color" "black"
                    , style "font-family" "lucida sans unicode,lucida grande, sans-serif"
                    , style "font-weight" "bold"
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
            , style "left" "300px"
            , style "padding" "0 140px"
            , style "position" "absolute"
            , style "top" "155px"
            , style "width" "400px"
            ]
            [ div [style "margin" "140px 0 0 20px", style "color" "red",style "font-size" "30px",style "font-weight" "bold"] [text "Game Over"]
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
       gate = displayDoors [Door miniMap.gate.position False]

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
    ([
        img[style "position" "absolute", style "margin-left" "15px",style "margin-top" "15px", style "width" "30px", style "height" "30px",src "./images/Attr/Health.png"][]
       ,img[style "position" "absolute", style "margin-left" "15px",style "margin-top" "75px", style "width" "30px", style "height" "30px",src "./images/Attr/Armor.png"][]
       ,img[style "position" "absolute", style "margin-left" "15px",style "margin-top" "135px",  style "width" "35px", style "height" "35px",src "./images/Attr/Bullet.png"][]
    ]++List.map (makeProgress attr r) [Health, Armor,Clip])
    -- ++(List.map (makeProgress attr r) [Health, Clip, Armor])

makeProgress : Attr -> Float -> AttrType -> Html Msg
makeProgress attr r t =
    let
        maxAttr = String.fromFloat <| (toFloat <| getMaxAttr t attr) * r
        valueAttr = String.fromFloat <| (toFloat <| getCurrentAttr t attr) * r
    in
    div 
    [style "margin-left" "67px",style "margin-bottom" "20px"]
    [ div
        [style "width" "50px", style "font-size" "20px",style "color" "Black"]
        [text (getAttrName t ++ ":")]
      , progress
        [ Html.Attributes.max maxAttr
        , Html.Attributes.value valueAttr
        ]
        [text (valueAttr ++ "/" ++ maxAttr)]
    ]