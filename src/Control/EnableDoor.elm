module Control.EnableDoor exposing (enableDoor,disableDoor)
import Model exposing (Me)
import Map.Map exposing (Door,Room,roomConfig)
import Map.MapDisplay exposing (drawDoors)

enableDoor : Me ->List Room ->  List Door ->List Int -> (List Door,List Door)
enableDoor me rooms doors clearList=
    let
        roomNow = getRoom me 
        needEnabledTemp = drawDoors roomNow
        -- d2=Debug.log "doors"  (needEnabledTemp,getRoom me)
        needEnabled = List.filter (\value -> List.member value.position (List.map (\t->t.position) doors)) needEnabledTemp
        -- d1=Debug.log "doors"  (needEnabled,.position <|  getRoom me)
        doorNew = List.filter (\value -> not <| List.member value.position (List.map (\t -> t.position) needEnabled)) doors
         ++ List.map (\value->{value|enable=True}) needEnabled

        getRoomNum = 
            let
                member = List.filter  (\value -> value.position==roomNow.position) rooms
            in
                case List.head member of 
                    Just a ->
                        a.roomNum
                    _ ->
                        0
        -- d2 = Debug.log "roomNum" (List.map (\value-> (value.position,value.roomNum)) rooms)
        -- d1 = Debug.log "clear" (clearList,getRoomNum)  
        -- d2 = Debug.log "corridor" (roomNow.position,inCorridor me)
    in
        if List.member getRoomNum clearList then 
            (disableDoor doors,[])
        else  
            if not <| inCorridor me then 
                (doorNew,needEnabled)
            else 
                (disableDoor doors,[])

inCorridor : Me -> Basics.Bool
inCorridor me =
    let
        x = toFloat <| (floor (me.x/2500))*2500
        y = toFloat <| (floor (me.y/2500))*2500
        -- d1=Debug.log "delta" (me.x-x,me.y-y)
    in
        (me.x-x>2000||me.y-y>2000||me.x-x<200||me.y-y<200)




getRoom : Me -> Room
getRoom me =
    let
        x = floor (me.x/2500)
        y = floor (me.y/2500)
        -- d1=Debug.log "x,y" (x,y)
    in
        {roomConfig|position=(x,y),road= [(-1+x,0+y),(0+x,-1+y),(1+x,0+y),(0+x,1+y)]}



disableDoor : List Door -> List Door
disableDoor door =
    List.map (\value -> {value|enable=False}) door
