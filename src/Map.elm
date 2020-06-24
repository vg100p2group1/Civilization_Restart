module Map exposing (mapWalls,mapMax,recInit,circleInit)
import Model exposing (Rectangle,Rec,recUpdate,Circle)

recInit : Rec
recInit = Rec 0 0 0 0

circleInit : Circle
circleInit = Circle 0 0 0

wall1 : Rectangle
wall1 = Rectangle 500 500 1000 400 recInit

wall2 : Rectangle 
wall2 = Rectangle 2000 1000 900 500 recInit

wall3 : Rectangle
wall3 = Rectangle 1500 2500 1000 1000 recInit

left : Rectangle
left = Rectangle -500 -500 500 5000 recInit


right : Rectangle
right = Rectangle 4000 -500 500 5000 recInit

top : Rectangle
top = Rectangle -500 -500 5000 500 recInit

bottom : Rectangle
bottom = Rectangle -500 4000 5000 500 recInit

mapWalls : List Rectangle
mapWalls = List.map recUpdate [wall1,wall2,wall3,left,right,top,bottom]

mapMax : Float
mapMax = 4000