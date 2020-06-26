module Map exposing (mapWalls,mapMax,recInit)
import Model exposing (Rectangle,Rec,recUpdate)

recInit : Rec
recInit = Rec 0 0 0 0

wall1 : Rectangle
wall1 = Rectangle 200 200 300 50 recInit

wall2 : Rectangle 
wall2 = Rectangle 200 200 50 650 recInit

wall3 : Rectangle
wall3 = Rectangle 200 1050 300 50 recInit

wall4 : Rectangle
wall4 = Rectangle 200 1350 50 1350 recInit

wall5 : Rectangle
wall5 = Rectangle 200 1350 300 50 recInit

wall6 : Rectangle
wall6 = Rectangle 200 1800 550 50 recInit

wall7 : Rectangle
wall7 = Rectangle 700 200 50 250 recInit

wall8 : Rectangle
wall8 = Rectangle 450 450 900 50 recInit

wall9 : Rectangle
wall9 = Rectangle 450 450 50 300 recInit

wall10 : Rectangle
wall10 = Rectangle 1000 200 900 50 recInit

wall11 : Rectangle
wall11 = Rectangle 1600 200 50 250 recInit

wall12 : Rectangle
wall12 = Rectangle 1500 450 150 50 recInit

wall13 : Rectangle
wall13 = Rectangle 1000 450 50 300 recInit

wall14 : Rectangle
wall14 = Rectangle 450 450 50 400 recInit

wall15 : Rectangle
wall15 = Rectangle 700 700 50 700 recInit

wall16 : Rectangle
wall16 = Rectangle 700 700 300 50 recInit

wall17 : Rectangle
wall17 = Rectangle 2350 200 300 50 recInit

wall18 : Rectangle
wall18 = Rectangle 2600 200 50 550 recInit

wall19 : Rectangle
wall19 = Rectangle 2050 450 600 50 recInit

wall20 : Rectangle
wall20 = Rectangle 1800 450 50 650 recInit

wall21 : Rectangle
wall21 = Rectangle 1800 700 650 50 recInit

wall22 : Rectangle
wall22 = Rectangle 2600 700 300 50 recInit

wall23 : Rectangle
wall23 = Rectangle 1250 700 400 50 recInit

wall24 : Rectangle
wall24 = Rectangle 1600 700 50 400 recInit


wall25 : Rectangle
wall25 = Rectangle 2850 700 50 500 recInit


wall26 : Rectangle
wall26 = Rectangle 2600 1050 50 300 recInit


wall27 : Rectangle
wall27 = Rectangle 2050 1050 600 50 recInit

wall28 : Rectangle
wall28 = Rectangle 2050 1050 50 300 recInit

wall29 : Rectangle
wall29 = Rectangle 1500 1300 550 50 recInit

wall30 : Rectangle
wall30 = Rectangle 1500 1300 50 550 recInit

wall31 : Rectangle
wall31 = Rectangle 1250 700 50 1150 recInit

wall32 : Rectangle
wall32 = Rectangle 700 1350 350 50 recInit

wall33 : Rectangle
wall33 = Rectangle 450 1600 800 50 recInit

wall34 : Rectangle
wall34 = Rectangle 200 2150 900 50 recInit

wall35 : Rectangle
wall35 = Rectangle 1300 2150 700 50 recInit

wall36 : Rectangle
wall36 = Rectangle 1800 1600 1000 50 recInit

wall37 : Rectangle
wall37 = Rectangle 2400 1300 50 1100 recInit

wall38 : Rectangle
wall38 = Rectangle 500 2650 700 50 recInit

wall39 : Rectangle
wall39 = Rectangle 1750 2650 1150 50 recInit

wall40 : Rectangle
wall40 = Rectangle 2700 2050 50 600 recInit

wall41 : Rectangle
wall41 = Rectangle 500 2450 50 350 recInit

wall42 : Rectangle
wall42 = Rectangle 2000 1850 50 650 recInit

wall43 : Rectangle
wall43 = Rectangle 1500 2150 50 600 recInit

wall44 : Rectangle
wall44 = Rectangle 1000 2450 500 50 recInit

wall45 : Rectangle
wall45 = Rectangle 800 2350 50 350 recInit

left : Rectangle
left = Rectangle -500 -500 500 4000 recInit


right : Rectangle
right = Rectangle 3000 -500 500 4000 recInit

top : Rectangle
top = Rectangle -500 -500 4000 500 recInit

bottom : Rectangle
bottom = Rectangle -500 3000 4000 500 recInit

mapWalls : List Rectangle
mapWalls = 
    let
        fourWalls = [left,right,top,bottom]
        wallList1 = [wall1,wall2,wall3,wall4,wall5,wall6,wall7,wall8,wall9,wall10,wall11,wall12,wall13,wall14,wall15]
        wallList2 = [wall16,wall17,wall18,wall19,wall20,wall21,wall22,wall23,wall24,wall25,wall26,wall27,wall28,wall29,wall30]
        
        wallList3 = [wall31,wall32,wall33,wall34,wall35,wall36,wall37,wall38,wall39,wall40,wall41,wall42,wall43,wall44,wall45]
        entireWalls = fourWalls ++ wallList1 ++ wallList2 ++ wallList3
    in
        List.map recUpdate entireWalls

mapMax : Float
mapMax = 3000