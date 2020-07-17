module Skill exposing (SkillSystem, SkillSubSystem, Skill)

type alias SkillSystem = 
    { subsys : List SkillSubSystem
    , current : Int
    }

type alias SkillSubSystem = 
    { skills : List Skill
    , name : String
    , chosen : (Int, Int)  -- The (id, level) of chosen Skill
    , points : Int
    , text : String
    }

type alias Skill = 
    { id : Int
    , level : Int
    , unlocked : Bool
    , desciption : String
    }

switchSubSystem : SkillSystem -> Int -> SkillSystem
switchSubSystem sys dir =
    let 
        total = List.length sys.subsys
        newCurr = sys.current + dir % total
    in
        {sys|current = newCurr}