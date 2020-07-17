module Skill exposing (SkillSystem, SkillSubSystem, Skill)
import Css exposing (true)

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
emptySkill = Skill -1 -1 False ""

switchSubSystem : SkillSystem -> Int -> SkillSystem
switchSubSystem sys dir =
    let 
        total = List.length sys.subsys
        newCurr = sys.current + dir % total
    in
        {sys|current = newCurr}

getSkill : SkillSubSystem -> (Int, Int) -> Maybe Skill
getSkill sys (id, level) =
    let
        chosenList = List.filter (\sk -> sk.id == id && sk.level == level) sys.skills
    in
        List.head chosenList

choose : SkillSubSystem -> (Int, Int) -> SkillSubSystem
choose sys (id, level) =
    let 
        maybeSkill = getSkill sys (id, level)
        skill = Maybe.withDefault emptySkill maybeSkill
    in
        {sys|chosen = (skill.id, skill.level), text = skill.desciption}


-- return Nothing if the skill not exist (player currently choose nothing).
-- return (inputSubsystem,0) back if the skill is already unlocked.
-- return (newSubsystem, cost) where newSubsystem have the skill unlocked and 
-- cost is the cost for this unlock if success
unlockChosen : SkillSubSystem -> Maybe (SkillSubSystem, Int)
unlockChosen sys = 
    let 
        (id, level) = sys.chosen
        maybeSkill = getSkill sys (id, level)
    in
        case maybeSkill of 
            Maybe.Nothing -> Maybe.Nothing
            Just skill ->
                if skill.unlocked then  -- the skill is already unlocked
                    (sys, 0)
                else  -- unlock the skill
                let
                    newSkill = {skill|unlocked = true}
                    newSkills = List.filter (\sk -> not (sk.id == id && sk.level == level)) sys.skills :: skill
                    cost = skill.level
                    newSubsystem = {sys | skills = newSkills}
                in
                    (newSubsystem, cost)