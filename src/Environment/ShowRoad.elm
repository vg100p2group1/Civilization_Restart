module Environment.ShowRoad exposing (showRoad,showMiddle)
import Svg 
import Svg.Attributes 
import Messages exposing (Msg)
import Shape exposing (Rectangle,recUpdate,recInit)

showRoad : (List Rectangle) -> List (Svg.Svg Msg)
showRoad roads =
    let
        filterFunction road =
               List.member (road.edge.cx,road.edge.cy+300) (List.map (\value -> (value.edge.cx,value.edge.cy)) roads ) || List.member (road.edge.cx+300,road.edge.cy) (List.map (\value -> (value.edge.cx,value.edge.cy)) roads )
        -- d1=Debug.log "roads" (List.filter filterFunction roads )

        createFormat oneRoad =
            if oneRoad.width>oneRoad.height then
                 Svg.use [Svg.Attributes.xlinkHref "#Road1"
                        ,Svg.Attributes.x <| String.fromFloat oneRoad.x
                        ,Svg.Attributes.y <| String.fromFloat (oneRoad.y-100)][] 
            else  
                Svg.use [Svg.Attributes.xlinkHref "#Road2"
                        ,Svg.Attributes.x <| String.fromFloat (oneRoad.x-100)
                        ,Svg.Attributes.y <| String.fromFloat oneRoad.y][]
    in  
        List.map (\value-> createFormat value) <| List.filter filterFunction roads 

showMiddle : (List Rectangle) -> List (Svg.Svg Msg)
showMiddle roads =
    let
        filterFunction road =
               List.member (road.edge.cx,road.edge.cy+300) (List.map (\value -> (value.edge.cx,value.edge.cy)) roads ) || List.member (road.edge.cx+300,road.edge.cy) (List.map (\value -> (value.edge.cx,value.edge.cy)) roads )
        createFormat oneRoad =
            if oneRoad.width>oneRoad.height then
                 Svg.use [Svg.Attributes.xlinkHref "#Hole"
                        ,Svg.Attributes.x <| String.fromFloat (oneRoad.x-50)
                        ,Svg.Attributes.y <| String.fromFloat (oneRoad.y-250)][] 
            else  
                Svg.use [Svg.Attributes.xlinkHref "#Hole"
                        ,Svg.Attributes.x <| String.fromFloat (oneRoad.x-250)
                        ,Svg.Attributes.y <| String.fromFloat (oneRoad.y-50)][]
    in  
        List.map (\value-> createFormat value) <| List.filter filterFunction roads 

