module Synthesis.SynthesisSystem exposing (SynthesisSubSystem,defaultSynthesisSubSystem)
type alias SynthesisSubSystem =
    { weaponNumber : Int
    , tip : String
    , active : Bool 
    }

defaultSynthesisSubSystem : SynthesisSubSystem
defaultSynthesisSubSystem = SynthesisSubSystem 0 "" False