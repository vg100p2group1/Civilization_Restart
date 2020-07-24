module Package.Package exposing (Package,packageInit)
-- import Package.Material exposing (Material(..))

type alias Package =
    { steel : Int   
    , copper : Int 
    , wolfram : Int 
    , uranium  : Int 
    }

type alias TreasureMaterial =
    { steel : Int   
    , copper : Int 
    , wolfram : Int 
    , uranium  : Int 
    }

packageInit : Package
packageInit = Package 0 0 0 0

-- packageUpdate : 
-- packageUpadate 