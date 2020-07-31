module MiniMap exposing (getMiniMap)
import Map.Map exposing (Map,Room,roomConfig,Gate)
import Shape exposing (recUpdate,Rectangle,recInit)


getMiniMap : Map-> List Room -> (Map,(Int,Int))
getMiniMap model rooms= 
    let
       mapTemp = {model|gate=getMiniMapGate rooms model.gate}
       (miniX,miniY) = getMini rooms
       updateMap = miniMapUpdate miniX miniY mapTemp
    in
       (updateMap,(miniX,miniY))


getMiniMapGate : List Room -> Gate -> Gate
getMiniMapGate rooms gate=
    let
        gateRoomList = List.filter (\value->value.gate) rooms

            -- d3=Debug.log "List" (List.map (\value -> {p=value.position,g=value.gate}) rooms)
        getRoom =
            case List.head gateRoomList of 
                Just a ->
                    a
                Nothing ->
                    roomConfig
        gateRoomTemp = getRoom
        (x,y) = gateRoomTemp.position
        newX = toFloat (2500*x)
        newY = toFloat (2500*y)

        updatedGate = recUpdate (Rectangle (500+newX) (500+newY) 1000 1000 recInit)
    in 
        {gate| position = updatedGate}


getMini : List Room -> (Int,Int)
getMini rooms = 
    let
        xList = List.map (\value -> Tuple.first value) <| List.map (\value -> value.position) rooms
        yList = List.map (\value -> Tuple.second value) <| List.map (\value -> value.position) rooms
        
        xHead = List.head <| List.sort xList
        yHead = List.head <| List.sort yList

        getHead model =
            case model of
               Just a ->
                   a
               Nothing ->
                    0
    in
        (getHead xHead,getHead yHead)


miniMapUpdate : Int -> Int -> Map -> Map 
miniMapUpdate x y model = 
    let
        posUpdate r =
            let
                xTemp = toFloat (x*2500)
                yTemp = toFloat (y*2500)
            in
                recUpdate {r|x=r.x-xTemp,y=r.y-yTemp}
        posListUpdate l =
            List.map (\value -> posUpdate value) l
        wallPosUpdate l =
            List.map (\value -> {value|position=posUpdate value.position}) l 
        gate = model.gate
    in
        {model|walls = wallPosUpdate model.walls, roads = posListUpdate model.roads,gate = {gate| position = posUpdate gate.position}}