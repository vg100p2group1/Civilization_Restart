module Map.ObstacleGenerator exposing (obstacleGenerator,bossRoomObstacleGenerator)
import Random
-- import Css exposing (visited)
import Map.Map exposing (Obstacle)
import Shape exposing (recInit,recUpdate,Rectangle)
-- import Model exposing (recUpdate)


obstacleConfig : Obstacle
obstacleConfig = Obstacle (Rectangle 0 0 0 0 recInit)


roomA : List Obstacle
roomA = 
    let
        -- a1=Rectangle 400 400 400 200 recInit
        -- a2=Rectangle 1200 400 400 200 recInit
        -- a3=Rectangle 400 1400 400 200 recInit
        -- a4=Rectangle 1200 1400 400 200 recInit
        -- roomTemp=[{obstacleConfig|position = a1},{obstacleConfig|position = a2},{obstacleConfig|position = a3},{obstacleConfig|position = a4}]
        roomTemp=[]
    in
        List.map (\value -> {value|position = recUpdate value.position}) roomTemp

roomB : List Obstacle
roomB = 
    let
        a1=Rectangle 600 600 800 800 recInit
        roomTemp=[{obstacleConfig|position = a1}]
    in
        List.map (\value -> {value|position = recUpdate value.position}) roomTemp
roomC : List Obstacle
roomC= 
    let
        a1=Rectangle 800 400 400 200 recInit
        a2=Rectangle 400 800 400 200 recInit
        a3=Rectangle 1200 800 400 200 recInit
        a4=Rectangle 800 1200 400 200 recInit
        roomTemp=[{obstacleConfig|position = a1},{obstacleConfig|position = a2},{obstacleConfig|position = a3},{obstacleConfig|position = a4}]
    in
        List.map (\value -> {value|position = recUpdate value.position}) roomTemp

roomD : List Obstacle
roomD = 
    let
        a1=Rectangle 400 400 400 200 recInit
        a2=Rectangle 1200 400 400 200 recInit
        a3=Rectangle 400 1400 400 200 recInit
        a4=Rectangle 1200 1400 400 200 recInit
        roomTemp=[{obstacleConfig|position = a1},{obstacleConfig|position = a2},{obstacleConfig|position = a3},{obstacleConfig|position = a4}]
    in
        List.map (\value -> {value|position = recUpdate value.position}) roomTemp

roomList : List (List Obstacle)
roomList = [roomA,roomD,roomB,roomC]



obstacleGenerator : Random.Seed -> (List Obstacle,Random.Seed)
obstacleGenerator seed0 = 
    let
        (roomnum,seed1)=Random.step (Random.int 0 3) seed0
        roomTemp = List.head <| List.drop roomnum roomList
        -- d1=Debug.log "roomnum" roomnum
        -- d2=Debug.log "rooms" (List.drop roomnum roomList)
        getRoom =
            case roomTemp of
                Just a ->
                    a
                Nothing ->
                    [obstacleConfig]
    in
        (getRoom,seed1)


bossRoomObstacleGenerator : Random.Seed -> (List Obstacle,Random.Seed)
bossRoomObstacleGenerator seed0 = 
    let
        (roomnum,seed1)=Random.step (Random.int 0 1) seed0
        roomTemp = List.head <| List.drop roomnum roomList
        -- d1=Debug.log "roomnum" roomnum
        -- d2=Debug.log "rooms" (List.drop roomnum roomList)
        getRoom =
            case roomTemp of
                Just a ->
                    a
                Nothing ->
                    [obstacleConfig]
    in
        (getRoom,seed1)