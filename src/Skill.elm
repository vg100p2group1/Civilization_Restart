module Skill exposing (SkillSystem, SkillSubSystem, Skill)

type alias SkillSystem = 
    { subsys : List SkillSubSystem
    , current : Int
    , points : Int
    }

type alias SkillSubSystem = 
    { skills : List Skill
    , name : String
    , chosen : (Int, Int)  -- The (id, level) of chosen Skill
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

switchSubSystem : SkillSystem -> Int -> SkillSystem
switchSubSystem sys dir =
    let 
        total = List.length sys.subsys
        newCurr = sys.current + dir % total
    in
        {sys|current = newCurr}

choose : SkillSubSystem -> (Int, Int) -> SkillSubSystem
choose sys (id, level) =
    let 
        chosenList = List.filter (\sk -> sk.id == id && sk.level == level) sys.skills
        skill = Maybe.withDefault emptySkill (List.head chosenList)
    in
        {sys|chosen = (skill.id, skill.level), text = skill.desciption}