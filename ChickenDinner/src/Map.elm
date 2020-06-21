module Map exposing (mapWalls,mapMax,recInit)
import Model exposing (Rectangle,Rec,recUpdate)

recInit : Rec
recInit = Rec 0 0 0 0

wall1 : Rectangle
wall1 = Rectangle 500 500 1000 400 recInit

wall2 : Rectangle 
wall2 = Rectangle 2000 1000 900 500 recInit

wall3 : Rectangle
wall3 = Rectangle 1500 2500 1000 1000 recInit

mapWalls : List Rectangle
mapWalls = [recUpdate wall1, recUpdate wall2,recUpdate wall3]

mapMax : Float
mapMax = 4000