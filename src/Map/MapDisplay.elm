
module Map.MapDisplay exposing (mapWithGate, mapInit, showMap,drawDoors)
-- import MapGenerator exposing (..)
import Map.Map exposing (Room,Map,Monster,Treasure,roomConfig,mapConfig,Wall,WallProperty(..),Door,Boss)
import Shape exposing (recInit,Rectangle,recUpdate)

import Map.Gate exposing (gateGenerator)
import Map.MapGenerator exposing (roomInit)
import Random exposing (..)

mapInit : (List Room,Map)
mapInit = 
    mapWithGate (Tuple.first roomInit) (List.length (Tuple.first roomInit)) mapConfig (Random.initialSeed 0)

mapWithGate : List Room -> Int -> Map -> Random.Seed -> (List Room,Map)
mapWithGate rooms number drawnrooms seed0 = 
    let
        (mapTemp,roomNew) = showMap rooms number drawnrooms []
        (gateTemp, _) = gateGenerator rooms seed0
    in
        (roomNew,{mapTemp| gate=gateTemp,roomCount=number})


showMap : List Room -> Int -> Map-> List Room-> (Map,List Room)
showMap rooms number drawnrooms roomNew=
    let
        roomNowTemp = List.head rooms 
        getRoomNow = 
            case roomNowTemp of 
                Just a ->
                    a
                Nothing ->
                    roomConfig
        roomNow = getRoomNow 

        roomAppended = roomNew ++ [{roomNow|roomNum=number}]

        newRooms = List.drop 1 rooms

        monstersNew = drawMonsters roomNow number
        treasureNew = drawTreasure roomNow number
        obstaclesNew= drawObstacle roomNow 
        roadsNew=drawRoads roomNow

        wallsNew=drawWalls roomNow
        doorsNew=drawDoors roomNow
        bossNew=drawBoss roomNow number
    in
        if number == 0 then 
            (drawnrooms,roomAppended)
        else 
            showMap newRooms (number - 1)  
                {   drawnrooms|walls=drawnrooms.walls++wallsNew,
                    roads=drawnrooms.roads++roadsNew,
                    obstacles=drawnrooms.obstacles++obstaclesNew,
                    monsters=drawnrooms.monsters++monstersNew,
                    doors=drawnrooms.doors++doorsNew,
                    treasure=drawnrooms.treasure++treasureNew,
                    boss=drawnrooms.boss++bossNew
                    }
                roomAppended

drawMonsters : Room -> Int -> List Monster
drawMonsters room number=
    let
        (x,y) = room.position
        newX = toFloat (2500*x)
        newY = toFloat (2500*y)
        monsterList = room.monsters
        movingRectangle model =
            let
                newModel = {model|x=model.x+newX,y=model.y+newY}
            in
                recUpdate newModel

        movingCircle model =
            let
                newModel = {model|cx=model.cx+newX,cy=model.cy+newY}
            in
                newModel
    in
        List.map (\value->{value| region = movingRectangle value.region,position = movingCircle value.position,roomNum=number}) monsterList

drawBoss : Room -> Int -> List Boss
drawBoss room number=
    let
        (x,y) = room.position
        newX = toFloat (2500*x)
        newY = toFloat (2500*y)
        monsterList = room.boss
        movingRectangle model =
            let
                newModel = {model|x=model.x+newX,y=model.y+newY}
            in
                recUpdate newModel

       
    in
        List.map (\value->{value| position = movingRectangle value.position,roomNum=number}) monsterList
drawTreasure : Room -> Int -> List Treasure
drawTreasure room number=
    let
        (x,y) = room.position
        -- newX = Debug.log "build" toFloat (2500*x)
        newX = toFloat (2500*x)
        newY = toFloat (2500*y)
        treasureList = room.treasure
        movingRectangle model =
            let
                newModel = {model|x=model.x+newX,y=model.y+newY}
            in
                recUpdate newModel

    in
        List.map (\value->{value| position = movingRectangle value.position,roomNum=number}) treasureList

drawObstacle : Room -> List Rectangle
drawObstacle room =
    let
        (x,y) = room.position
        newX = toFloat (2500*x)
        newY = toFloat (2500*y)
        obstacleList = room.obstacles
        movingRectangle model =
            let
                newModel = {model|x=model.x+newX,y=model.y+newY}
            in
                recUpdate newModel
    in
        List.map movingRectangle <| List.map (\value -> value.position) obstacleList


drawDoors : Room -> List Door
drawDoors room =
    let
        (x,y) = room.position
        newX = toFloat (2500*x)
        newY = toFloat (2500*y)

        recPosition model =
            case model of 
                (2,1) ->
                    Rectangle (newX+1800) (newY+900) 100 200 recInit
                (1,2) ->
                    Rectangle (newX+900) (newY+1800) 200 100 recInit
                (0,1) ->
                    Rectangle (newX+100) (newY+900) 100 200 recInit
                (1,0) ->
                    Rectangle (newX+900) (newY+100) 200 100 recInit
                _ ->
                    Rectangle 0 0 0 0 recInit
            
        
        roadList1 = room.road
        roadList2 = List.map (\value -> ( Tuple.first value - x + 1, Tuple.second value - y + 1)) roadList1
        -- d1 = Debug.log "roadList" (roadList1,roadList2)
    in
        List.map (\value -> Door value False)<| List.map recUpdate <| List.map recPosition roadList2


drawRoads : Room -> List Rectangle
drawRoads room = 
    let
        (x,y) = room.position
        newX = toFloat (2500*x)
        newY = toFloat (2500*y)

        recPosition model =
            case model of 
                (2,1) ->
                    [Rectangle (newX + 1800) (newY + 800) 900 100 recInit,Rectangle (newX + 1800) (newY + 1100) 900 100 recInit]
                (1,2) ->
                    [Rectangle (newX + 800) (newY + 1800) 100 900 recInit,Rectangle (newX + 1100) (newY + 1800) 100 900 recInit]
                (0,1) ->
                    [Rectangle (newX - 700) (newY + 800) 900 100 recInit,Rectangle (newX - 700) (newY + 1100) 900 100 recInit]
                (1,0) ->
                    [Rectangle (newX + 800) (newY - 700) 100 900 recInit,Rectangle (newX + 1100) (newY - 700) 100 900 recInit]
                _ ->
                    [Rectangle 0 0 0 0 recInit]
            
        
        roadList1 = room.road
        roadList2 = List.map (\value -> ( Tuple.first value - x + 1, Tuple.second value - y + 1)) roadList1
    in
        List.map recUpdate <| List.concat <| List.map recPosition roadList2
    

drawWalls : Room -> List Wall
drawWalls room=
    let
        (x,y) = room.position
        newX = toFloat (2000*x+500*x)
        newY = toFloat (2000*y+500*y)

        roadList1 = room.road

        -- d1=Debug.log "p" room.position
        -- d2=Debug.log "edge" roadList1


        roadList2 = List.map (\value -> ( Tuple.first value - x + 1, Tuple.second value- y + 1)) roadList1

        -- d3 = Debug.log "update" roadList2 
        newRec1 = 
            if List.member (0,1) roadList2 then
                [Wall (Rectangle newX (newY+150) 200 650 recInit) LeftWall, Wall (Rectangle newX (newY+1200) 200 650 recInit) LeftWall]
                -- []
            else
                [Wall (Rectangle newX (newY+150) 200 1700 recInit) LeftWall]
        newRec2 = 
            if List.member (1,0) roadList2 then 
                [Wall (Rectangle (newX+200) newY 600 200 recInit) UpWall, Wall (Rectangle (newX+1200) newY 600 200 recInit) UpWall]
                -- []
            else  
                [Wall (Rectangle (newX+200) newY 1600 200 recInit) UpWall]
        newRec3 = 
            if List.member (2,1) roadList2 then
                [Wall (Rectangle (newX+1800) (newY+150) 200 650 recInit) RightWall, Wall (Rectangle (newX+1800) (newY+1200) 200 650 recInit) RightWall]
                -- []
            else 
                [Wall (Rectangle (newX+1800) (newY+150) 200 1700 recInit) RightWall]
        newRec4 = 
            if List.member (1,2) roadList2 then
                [Wall (Rectangle (newX+200) (newY+1800) 600 200 recInit) DownWall, Wall (Rectangle (newX+1200) (newY+1800) 600 200 recInit) DownWall]
                -- []
            else 
                [Wall (Rectangle (newX+200) (newY+1800) 1600 200 recInit) DownWall]
        
    in
        List.map (\value->{value| position=recUpdate value.position}) (List.concat [newRec1,newRec2,newRec3,newRec4])