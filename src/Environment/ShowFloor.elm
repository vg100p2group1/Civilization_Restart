module Environment.ShowFloor exposing (showFloor)
import Svg 
import Svg.Attributes 
import Shape exposing (Rectangle)
import Map.Map exposing (Room,roomConfig)
import Model exposing (Model,Me)
import Messages exposing (Msg)

showFloor : Model -> List (Svg.Svg Msg)
showFloor model =
    let
        rooms = Tuple.first model.rooms
        seed0 = Tuple.second model.rooms
    in
        showRooms rooms model.myself (List.length rooms) []

showRooms : (List Room) -> Me -> Int -> List (Svg.Svg Msg) -> List (Svg.Svg Msg)
showRooms roomLeft me number svgList =
    let
        roomNowTemp = List.head roomLeft
        roomLeftNew = List.drop 1 roomLeft 
        roomNow = 
            case roomNowTemp of
                Just a ->
                    a
                _ ->
                    roomConfig
        
        svgNew = svgList ++ (showOneRoom roomNow me)
    in
        if (number==0) then
            svgList
        else 
            showRooms roomLeftNew me (number-1) svgNew

showOneRoom : Room -> Me -> List (Svg.Svg Msg)
showOneRoom room me=
    let
        (x,y) = room.position
        xBegin = (toFloat (x*2500+200)) - me.x + 500
        -- xEnd = toFloat <| (x*2500+1800)

        yBegin = (toFloat (y*2500+200)) - me.y + 500
        -- yEnd = toFloat <| (y*2500+1800)

        num = 1600 / 50
        
        -- roomFloor = showRoomFloor xBegin xBegin yBegin num num [] 
        roomFloor = showOneFloor xBegin yBegin 
    in
        [showOneLight xBegin yBegin,roomFloor]

-- showRoomFloor : Float -> Float -> Float -> Float -> Float -> List (Svg.Svg Msg) -> List (Svg.Svg Msg)
-- showRoomFloor xBegin x y numX numY svgList=
--     if numY==0 then
--         svgList
--     else 
--        if numX==0 then
--             showRoomFloor xBegin xBegin (y+50) (1600/50) (numY-1) (svgList ++ [showOneFloor x y])
--        else 
--             showRoomFloor xBegin (x+50) y (numX-1) numY (svgList++[showOneFloor x y])
    
    



showOneFloor : Float -> Float -> Svg.Svg Msg
showOneFloor x y =
        Svg.use [Svg.Attributes.xlinkHref "#Floor1"
                ,Svg.Attributes.x <| String.fromFloat x
                ,Svg.Attributes.y <| String.fromFloat y][]

showOneLight : Float -> Float -> Svg.Svg Msg
showOneLight x y =
        Svg.use [Svg.Attributes.xlinkHref "#Light"
                ,Svg.Attributes.x <| String.fromFloat (x-200)
                ,Svg.Attributes.y <| String.fromFloat (y-200)][]