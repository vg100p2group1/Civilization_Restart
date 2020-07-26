module Synthesis.Package exposing (Package,packageInit,packageUpdate)
import Map.Map exposing (Treasure)


type alias Package =
    { steel : Int   
    , copper : Int 
    , wolfram : Int 
    , uranium  : Int 
    }

packageInit : Package
packageInit = Package 0 0 0 0

packageUpdate : Package -> Treasure -> Package
packageUpdate package treasure =
    let
        material=treasure.material
        -- d = Debug.log "d" material
        newPackage = Package (package.steel+material.steel) (package.copper+material.copper) (package.wolfram+material.wolfram) (package.wolfram+material.wolfram) 
    in
        newPackage