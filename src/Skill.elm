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
    , unlockLevel : Int
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
switchSubSystem sys dire =
    let 
        total = List.length sys.subsys
        newCurr = sys.current + modBy total dire
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

canUnlockLevel : SkillSubSystem -> Int -> Bool
canUnlockLevel sys level =
    sys.unlockLevel + 1 >= level

-- return Nothing if the skill not exist (player currently choose nothing).
-- return (inputSubsystem,0) back if the skill is already unlocked or some requirements are not satisfied.
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
                if skill.unlocked || not (canUnlockLevel sys skill.level) then  -- the skill is already unlocked
                    Just (sys, 0)
                else  -- unlock the skill
                let
                    newSkill = {skill|unlocked = True}
                    newSkills = newSkill :: List.filter (\sk -> not (sk.id == id && sk.level == level)) sys.skills
                    newUnlocklevel = Basics.max sys.unlockLevel skill.level
                    newSubsystem = {sys | skills = newSkills, unlockLevel = newUnlocklevel}
                    cost = skill.level
                in
                    Just (newSubsystem, cost)