module Skill exposing (SkillSystem, SkillSubSystem, Skill, defaultSystem, switchSubSystem, choose, unlockChosen, canUnlockLevel, getCurrentSubSystem)

type alias SkillSystem = 
    { subsys : List SkillSubSystem
    , current : Int
    , points : Int
    , active : Bool
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
emptySkill = Skill -1 1000 False "Nothing"

getCurrentSubSystem : SkillSystem -> SkillSubSystem
getCurrentSubSystem sys = 
    sys.subsys
    |> List.drop sys.current
    |> List.head
    |> Maybe.withDefault defaultSubSystem

switchSubSystem : SkillSystem -> Int -> SkillSystem
switchSubSystem sys dire =
    let 
        total = List.length sys.subsys
        newCurr = modBy total (sys.current + dire)
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

-- return (inputSubsystem,0) back if the skill is already unlocked, some requirements are not satisfied,
-- or the skill not exist (player currently choose nothing).
-- return (newSubsystem, cost) where newSubsystem have the skill unlocked and 
-- cost is the cost for this unlock if success
unlockChosen : SkillSubSystem -> (SkillSubSystem, Int)
unlockChosen sys = 
    let 
        (id, level) = sys.chosen
        maybeSkill = getSkill sys (id, level)
    in
        case maybeSkill of 
            Maybe.Nothing -> (sys, 0)
            Just skill ->
                if skill.unlocked || not (canUnlockLevel sys skill.level) then  -- the skill is already unlocked
                    (sys, 0)
                else  -- unlock the skill
                let
                    newSkill = {skill|unlocked = True}
                    newSkills = newSkill :: List.filter (\sk -> not (sk.id == id && sk.level == level)) sys.skills
                    newUnlocklevel = Basics.max sys.unlockLevel skill.level
                    newSubsystem = {sys | skills = newSkills, unlockLevel = newUnlocklevel}
                    cost = skill.level
                in
                    (newSubsystem, cost)

-- Define all the skills:
skill010 : Skill
skill010 = 
    { id = 0
    , level = 1
    , unlocked = False
    , desciption = "Skill 0 level 1 in subsystem 0"
    }

skill011 : Skill
skill011 = 
    { id = 1
    , level = 1
    , unlocked = False
    , desciption = "Skill 1 level 1 in subsystem 0"
    }

skill020 : Skill
skill020 = 
    { id = 0
    , level = 2
    , unlocked = False
    , desciption = "Skill 0 level 2 in subsystem 0"
    }

skill021 : Skill
skill021 = 
    { id = 1
    , level = 2
    , unlocked = False
    , desciption = "Skill 1 level 2 in subsystem 0"
    }

skill030 : Skill
skill030 = 
    { id = 0
    , level = 3
    , unlocked = False
    , desciption = "Skill 0 level 3 in subsystem 0"
    }

skill031 : Skill
skill031 = 
    { id = 1
    , level = 3
    , unlocked = False
    , desciption = "Skill 1 level 3 in subsystem 0"
    }

skill110 : Skill
skill110 = 
    { id = 0
    , level = 1
    , unlocked = False
    , desciption = "Skill 0 level 1 in subsystem 1"
    }

skill111 : Skill
skill111 = 
    { id = 1
    , level = 1
    , unlocked = False
    , desciption = "Skill 1 level 1 in subsystem 1"
    }

skill120 : Skill
skill120 = 
    { id = 0
    , level = 2
    , unlocked = False
    , desciption = "Skill 0 level 2 in subsystem 1"
    }

skill121 : Skill
skill121 = 
    { id = 1
    , level = 2
    , unlocked = False
    , desciption = "Skill 1 level 2 in subsystem 1"
    }

skill130 : Skill
skill130 = 
    { id = 0
    , level = 3
    , unlocked = False
    , desciption = "Skill 0 level 3 in subsystem 1"
    }

skill131 : Skill
skill131 = 
    { id = 1
    , level = 3
    , unlocked = False
    , desciption = "Skill 1 level 3 in subsystem 1"
    }

skillShootingSkillI : Skill
skillShootingSkillI = 
    { id = 0
    , level = 1
    , unlocked = False
    , desciption = "Skill: Shooting SKill I in subsystem Berserker"
    }

skillAmplifyDamageI : Skill
skillAmplifyDamageI = 
    { id = 0
    , level = 2
    , unlocked = False
    , desciption = "Skill: Amplify Damage I in subsystem Berserker"
    }

skillShootingSkillII : Skill
skillShootingSkillII = 
    { id = 0
    , level = 3
    , unlocked = False
    , desciption = "Skill: Shooting SKill II in subsystem Berserker"
    }

skillAmplifyDamageII : Skill
skillAmplifyDamageII = 
    { id = 1
    , level = 3
    , unlocked = False
    , desciption = "Skill: Amplify Damage in subsystem Berserker"
    }

skillBattleFervor : Skill
skillBattleFervor = 
    { id = 0
    , level = 4
    , unlocked = False
    , desciption = "Skill: Battle Fervor in subsystem Berserker"
    }

skillDualWield : Skill
skillDualWield = 
    { id = 1
    , level = 4
    , unlocked = False
    , desciption = "Skill: Dual Wield in subsystem Berserker"
    }

subSys0 : SkillSubSystem
subSys0 = 
    { skills = [skill010, skill011, skill020, skill021, skill030, skill031]
    , name = "SubSystem 0"
    , chosen = (-1,-1)
    , text = ""
    , unlockLevel = 0
    }

subSys1 : SkillSubSystem
subSys1 = 
    { skills = [skill110, skill111, skill120, skill121, skill130, skill131]
    , name = "SubSystem 1"
    , chosen = (-1,-1)
    , text = ""
    , unlockLevel = 0
    }

subSysBerserker : SkillSubSystem
subSysBerserker = 
    { skills = 
        [ skillShootingSkillI
        , skillAmplifyDamageI
        , skillShootingSkillII, skillAmplifyDamageII
        , skillBattleFervor, skillDualWield
        ]
    , name = "Berserker"
    , chosen = (-1,-1)
    , text = ""
    , unlockLevel = 0
    }

defaultSubSystem : SkillSubSystem
defaultSubSystem = subSys0

defaultSystem : SkillSystem
defaultSystem = 
    { subsys = [subSys0, subSys1, subSysBerserker]
    , current = 0
    , points = 10
    , active = False
    }