module Map.Gate exposing (gateGenerator,updateGate)
import Map.Map exposing (Room,roomConfig,Gate)
import Shape exposing (recInit,recUpdate,recCollisionTest,Rectangle)
import Random
-- import Svg.Styled.Attributes exposing (x)

gateGenerator : List Room-> Random.Seed -> (Gate,Random.Seed)
gateGenerator rooms seed0 =
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
        (gate,seed1) = findPosition gateRoomTemp seed0
        (x,y) = gateRoomTemp.position
        newX = toFloat (2500*x)
        newY = toFloat (2500*y)

        updatedGate = recUpdate (Rectangle (gate.x+newX) (gate.y+newY) 200 200 recInit)
        -- d = Debug.log "gate" updatedGate
        -- d1=Debug.log "x" x
        -- d2=Debug.log "y" y
    in
        (Gate updatedGate 0 gateRoomTemp.roomNum False,seed1)


findPosition : Room -> Random.Seed -> (Rectangle,Random.Seed)
findPosition room seed0= 
    let
        xTemp = 1000
        yTemp = 1000
        gateTemp = recUpdate (Rectangle (toFloat xTemp) (toFloat yTemp) 200 200 recInit) 
        obstaclePosList = List.map (\value -> value.position)  room.obstacles
        treasurePosList = List.map (\value -> value.position) room.treasure
        gateCollision=List.filter (recCollisionTest gateTemp.edge) <| List.map (\value->value.edge) obstaclePosList ++ List.map (\value->value.edge)  treasurePosList

    in
        if List.isEmpty gateCollision then
            (gateTemp,seed0)
        else 
            findPosition room seed0


updateGate : Gate ->  List Int ->  Map.Map.Gate
updateGate  gate roomClearList =
    if List.member gate.roomNum roomClearList then {gate|canShow=True}else gate