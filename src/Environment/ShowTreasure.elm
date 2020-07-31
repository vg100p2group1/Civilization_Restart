module Environment.ShowTreasure exposing (displayTreasure)
import Map.Map exposing (Treasure)
import Svg 
import Svg.Attributes 
import Messages exposing (Msg)

displayTreasure : List Treasure  -> List (Svg.Svg Msg)
displayTreasure treasure =
    let
        -- d=Debug.log "wall" obstacle
        createBricksFormat treasureTemp =
            let
                model = treasureTemp.position
                treasureType = treasureTemp.treasureType
                

                treasureColor = treasureType.color
            in
                if not treasureTemp.canShow  then 
                Svg.rect
                    [ Svg.Attributes.x <| String.fromFloat model.x
                    , Svg.Attributes.y <| String.fromFloat model.y
                    , Svg.Attributes.width <| String.fromFloat 0
                    , Svg.Attributes.height <| String.fromFloat 0
                    , Svg.Attributes.fill treasureColor
                
                    ]
                []
                else
                    Svg.use [Svg.Attributes.xlinkHref "#Treasure1"
                    ,Svg.Attributes.x <| String.fromFloat model.x
                    ,Svg.Attributes.y <| String.fromFloat model.y][]
    in
        List.map createBricksFormat treasure