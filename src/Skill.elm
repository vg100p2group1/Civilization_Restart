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

emptySkill : Skill
emptySkill = Skill 0 0 False ""