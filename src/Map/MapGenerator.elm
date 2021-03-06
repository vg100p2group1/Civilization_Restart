module Map.MapGenerator exposing (roomGenerator,roomInit)
import Random
import Map.Map exposing (Room,Treasure,roomConfig)
import Map.ObstacleGenerator exposing (obstacleGenerator,bossRoomObstacleGenerator)
import Map.MonsterGenerator exposing (monsterGenerator)
import Map.TreasureGenerator exposing (treasureGenerator,treasureLevelChange)
import Monster.Boss exposing (bossGenerator)
-- import Html
-- import Html.Events exposing (onClick)
-- import Browser

roomInit : (List Room, Random.Seed)
roomInit = 
    roomGenerator 1 (Random.initialSeed 0)

roomGenerator : Int -> Random.Seed -> (List Room,Random.Seed)
roomGenerator storey seed0 = 
    let
        (room1,seed1) = roomPositionGenerator storey seed0
        --  room2 = roomUpdate room1
        -- d = Debug.log "room" (List.map (\value->value.position) room1)
    in
        (roomUpdate room1,seed1)

--有向图 转 无向图
roomUpdate : List Room -> List Room
roomUpdate room =
    let
        findRoom model =
            let 
                appendList = List.map (\value->value.position) <| List.filter (\value -> List.member model.position value.road) room
            in
                {model|road=model.road++appendList}  
    in
        List.map findRoom room 

roomPositionGenerator : Int -> Random.Seed -> (List Room, Random.Seed)
roomPositionGenerator storey seed0= 
    let
        (roomNumber,seed1) = Random.step (Random.int 5 7) seed0 
        -- d = Debug.log "roomNumber" roomNumber

        (room1,newNumber,seed2) = firstRoomGenerator roomNumber seed1 storey

        room =[{roomConfig| road = [room1.position],rank=roomNumber+1}]

        (room2,seed3)=otherRoomGenerator [room1] room newNumber seed2 storey
        
        room3 = List.sortBy .rank room2
        gateRoom = List.head room3
        getGateRoom = 
            case gateRoom of
                Just a ->
                    a
                Nothing ->
                    roomConfig
        
        gateRoomTemp = getGateRoom
        whetherBoss =
            if  modBy 2 storey== 1 then
                {gateRoomTemp|haveBoss=True,gate=True}
            else
                {gateRoomTemp|gate=True}
        newBoss = 
            if whetherBoss.haveBoss then 
                bossGenerator seed3 whetherBoss.obstacles storey
            else []

        newMonster = 
            if whetherBoss.haveBoss then 
                []
            else whetherBoss.monsters
        newTreasure = List.map treasureLevelChange whetherBoss.treasure
        newRoom = {whetherBoss|boss=newBoss,monsters=newMonster,treasure = newTreasure}

        room4 = newRoom :: (List.drop 1 room3) 
        -- d2 = Debug.log "gateroom" whetherBoss
    in
        (room4,seed3)



firstRoomGenerator : Int -> Random.Seed -> Int ->  (Room,Int,Random.Seed)
firstRoomGenerator number seed0 storey=
    let
        (room0Direction,seed1) = Random.step (Random.int 0 1) seed0
        (obstacleTemp,seed2) = obstacleGenerator seed1
        (monsterTemp,seed3) = monsterGenerator seed2 obstacleTemp storey
        (treasureTemp,seed4) = treasureGenerator seed3 obstacleTemp storey 
    in
        if room0Direction == 0 then
            ({roomConfig|position=(1,0),rank=number,obstacles=obstacleTemp,monsters=monsterTemp,treasure=treasureTemp},number - 1,seed4)
        else 
            ({roomConfig|position=(0,1),rank=number,obstacles=obstacleTemp,monsters=monsterTemp,treasure=treasureTemp},number - 1,seed4)

otherRoomGenerator : List Room -> List Room -> Int -> Random.Seed-> Int -> (List Room, Random.Seed)
otherRoomGenerator roomList rooms number seed0 storey= 
    let 
        -- BFS
        -- pick the first room in the queue
        roomNowTemp = List.head roomList
        getRoom = 
         case roomNowTemp of
            Just a -> 
                a
            Nothing ->
                roomConfig
        roomNow = getRoom
        -- drop the first room
        newRoomList = List.drop 1 roomList
        
        -- get the available rooms
        (availableRoom,t) = checkroom roomNow rooms

        -- random, but guarantee it will keep extending until number = 0
        getRandomFunction = 
            if  List.isEmpty newRoomList then 
                 Random.int 1 t
            else 
                 Random.int 0 t
        (rTemp,seed1) = Random.step getRandomFunction seed0

        r = min rTemp number

        -- pick r rooms from available Room 
        (roomAdded,seed2) = roomPicking availableRoom (t - r) seed1

        (obstacleTemp,seed3) = obstacleGenerator seed2
        (monsterTemp,seed4) = monsterGenerator seed3 obstacleTemp storey
        (treasureTemp,seed5) = treasureGenerator seed4 obstacleTemp storey

        roomNowUpdated = {roomNow|road= (List.map (\value -> value.position) roomAdded),rank=number,obstacles=obstacleTemp,monsters=monsterTemp,treasure=treasureTemp}
    in 
        if number == 0 then 
            ((rooms ++ (leavesUpdate [] roomList (List.length roomList) seed3) storey),seed4)
        else
            otherRoomGenerator (newRoomList ++ roomAdded) (rooms ++ [roomNowUpdated]) (number - r) seed4 storey

leavesUpdate : List Room -> List Room -> Int -> Random.Seed-> Int -> List Room 
leavesUpdate  roomUpdated roomList num seed0 storey=
    let
        -- d=Debug.log "roomList" (List.map (\value->value.position) roomList)
        (obstacleTemp, seed1) = bossRoomObstacleGenerator seed0
        (monsterTemp,seed2) = monsterGenerator seed1 obstacleTemp storey -- 到时候把boss 给剔除出去
        (treasureTemp, seed3) = treasureGenerator seed2 obstacleTemp storey
        roomTemp = List.head roomList
        roomListNew = List.drop 1 roomList
        getRoom = 
            case roomTemp of 
                Just a ->
                    a
                Nothing ->
                    roomConfig
        roomNewTemp = getRoom
        roomNew = {roomNewTemp| obstacles = obstacleTemp,treasure=treasureTemp,monsters=monsterTemp,boss=[]} 
    in 
        if num==0 then
            roomUpdated
        else
            if checkOverlap roomNew roomListNew then 
                leavesUpdate (roomUpdated) roomListNew (num - 1) seed3 storey
            else 
                leavesUpdate (roomUpdated++[roomNew]) roomListNew (num - 1) seed3 storey
        
checkOverlap : Room -> List Room -> Bool
checkOverlap room roomList =
    let
        roomPosList = List.map (\value -> value.position) roomList
    in
        List.member room.position roomPosList





checkroom : Room -> List Room -> (List Room, Int)
checkroom position rooms=
    let 
        (x,y) = (Tuple.first position.position,Tuple.second position.position)
        initRoomList = [{roomConfig|position=(x+1,y)},{roomConfig|position=(x,y+1)},{roomConfig|position=(x - 1, y)},{roomConfig|position=(x, y - 1)}]
        availableRoom = List.filter (\value -> not (List.member value.position (List.map (\roomTemp -> roomTemp.position) rooms)) ) initRoomList 
    in 
        (availableRoom,  List.length availableRoom)

roomPicking : List Room -> Int -> Random.Seed -> ((List Room),Random.Seed)
roomPicking  availableRoom r seed0 =
    let
        randomFunction = Random.int 0 ((List.length availableRoom) - 1)
        (num,seed1) = Random.step randomFunction seed0 
        -- d = Debug.log "roompicking" num
        newList1 = List.take (num) availableRoom
        newList2 = List.drop (num+1) availableRoom  
    in
        if r==0 then 
            (availableRoom,seed1)
        else 
            roomPicking (newList1 ++ newList2) (r - 1) seed1


-- view : Model -> Html.Html Msg
-- view model =
--     let
--         seed0 = model.seed
--         (rooms,seed1) = roomGenerator 1 seed0
--         roomDisplay = List.map (\value -> Html.div[][Html.text ("("++(String.fromInt <| Tuple.first value.position) ++","++(String.fromInt <| Tuple.second value.position)++")") ]) rooms
--     in
--         Html.div[][Html.div[]roomDisplay,Html.button[ onClick (Change seed1)][ Html.text "New" ]]

-- update msg model = 
--     case msg of 
--         Change newSeed -> 
--           {model| seed=newSeed}

-- type Msg = Change Random.Seed

-- type alias  Model =
--     { seed : Random.Seed
--     }

-- init = Model (Random.initialSeed 0)


-- main =
--     Browser.sandbox { init = init, update = update, view = view } 