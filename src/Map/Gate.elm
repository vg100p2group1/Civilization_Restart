module Map.Gate exposing (gateGenerator)
import Map.Map exposing (Room,roomConfig)
import Shape exposing (recInit,recUpdate,recCollisionTest,Rectangle)
import Random
import Svg.Styled.Attributes exposing (x)

gateGenerator : List Room-> Random.Seed -> (Rectangle,Random.Seed)
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

        updatedGate = recUpdate (Rectangle (gate.x+newX) (gate.y+newY) 100 100 recInit)
        -- d = Debug.log "gate" updatedGate
        -- d1=Debug.log "x" x
        -- d2=Debug.log "y" y
    in
        (updatedGate,seed1)


findPosition : Room -> Random.Seed -> (Rectangle,Random.Seed)
findPosition room seed0= 
    let
        (xTemp,seed1) = Random.step (Random.int 200 1600) seed0
        (yTemp,seed2) = Random.step (Random.int 200 1600) seed1
        gateTemp = recUpdate (Rectangle (toFloat xTemp) (toFloat yTemp) 100 100 recInit) 
        obstaclePosList = List.map (\value -> value.position)  room.obstacles
        gateCollision=List.filter (recCollisionTest gateTemp.edge) <| List.map (\value->value.edge) obstaclePosList

    in
        if List.isEmpty gateCollision then
            (gateTemp,seed2)
        else 
            findPosition room seed2

