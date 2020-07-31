
module Skill exposing (SkillSystem, SkillSubSystem, Skill, defaultSystem, switchSubSystem, choose, unlockChosen, canUnlockLevel
                      ,getCurrentSubSystem, getSubSys, getSkill,skillState,subSysBerserker,skillDualWield,subSysPhantom,skillFlash)

type alias SkillSystem = 
    { subsys : List SkillSubSystem
    , current : Int
    , points : Int
    , active : Bool
    }

type alias SkillSubSystem = 
    { id : Int
    , skills : List Skill
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
    , name : String
    }

emptySkill : Skill
emptySkill = Skill -1 1000 False "Nothing" "Empty Skill"

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

getSkill : SkillSubSystem -> (Int, Int) -> Skill
getSkill sys (id, level) =
    let
        chosenList = List.filter (\sk -> sk.id == id && sk.level == level) sys.skills
    in
        Maybe.withDefault emptySkill (List.head chosenList)

getSubSys : SkillSystem -> Int -> SkillSubSystem
getSubSys sys id =
    let
        sub = sys.subsys
            |> List.filter (\s -> s.id == id)
            |> List.head
            |>Maybe.withDefault defaultSubSystem 
    in
        sub
    

choose : SkillSubSystem -> (Int, Int) -> SkillSubSystem
choose sys (id, level) =
    let 
        skill = getSkill sys (id, level)
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
        skill = getSkill sys (id, level)
    in
        if skill.unlocked || not (canUnlockLevel sys skill.level) then  -- the skill is already unlocked or cannot unlock
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
skillSpeedUpI : Skill
skillSpeedUpI = 
    { id = 0
    , level = 1
    , unlocked = False
    , desciption = "Skill: Speed Up! I in subsystem Phantom"
    , name = "Speed Up! I"
    }

skillMissI : Skill
skillMissI = 
    { id = 0
    , level = 2
    , unlocked = False
    , desciption = "Skill: Miss I in subsystem Phantom"
    , name = "Miss I"
    }

skillSpeedUpII : Skill
skillSpeedUpII = 
    { id = 0
    , level = 3
    , unlocked = False
    , desciption = "Skill: Speed Up! II in subsystem Phantom"
    , name = "Speed Up! II"
    }

skillMissII : Skill
skillMissII = 
    { id = 1
    , level = 3
    , unlocked = False
    , desciption = "Skill: Miss II in subsystem Phantom"
    , name = "Miss II"
    }

skillFlash : Skill
skillFlash = 
    { id = 0
    , level = 4
    , unlocked = False
    , desciption = "Skill: Flash in subsystem Phantom"
    , name = "Flash"
    }

skillInvisible : Skill
skillInvisible = 
    { id = 1
    , level = 4
    , unlocked = False
    , desciption = "Skill: Invisible in subsystem Phantom"
    , name = "Invisible"
    }

skillArmorUpgradeI : Skill
skillArmorUpgradeI = 
    { id = 0
    , level = 1
    , unlocked = False
    , desciption = "Skill: Armor Upgrade I in subsystem Mechanic"
    , name = "Armor Upgrade I"
    }

skillArmorUpgradeII : Skill
skillArmorUpgradeII = 
    { id = 0
    , level = 2
    , unlocked = False
    , desciption = "Skill: Armor Upgrade II in subsystem Mechanic"
    , name = "Armor Upgrade II"
    }

skillMoreBullets : Skill
skillMoreBullets = 
    { id = 0
    , level = 3
    , unlocked = False
    , desciption = "Skill: More Bullets in subsystem Mechanic"
    , name = "More Bullets"
    }

skillDirectionalBlasting : Skill
skillDirectionalBlasting = 
    { id = 1
    , level = 3
    , unlocked = False
    , desciption = "Skill: Directional Blasing in subsystem Mechanic"
    , name = "Directional Blasting"
    }


skillAbsoluteTerritoryField : Skill
skillAbsoluteTerritoryField =
    { id = 0
    , level = 4
    , unlocked = False
    , desciption = "Skill: Absolute Territory Field in subsystem Mechanic"
    , name = "Absolute Territory Field"
    }

skillExplosionIsArt : Skill
skillExplosionIsArt = 
    { id = 1
    , level = 4
    , unlocked = False
    , desciption = "Skill: Explosion is Art in subsystem Mechanic"
    , name = "Explosion is Art"
    }

skillShootingSkillI : Skill
skillShootingSkillI = 
    { id = 0
    , level = 1
    , unlocked = False
    , desciption = "Skill: Shooting SKill I in subsystem Berserker"
    , name = "Shooting Skill I"
    }


skillAmplifyDamageI : Skill
skillAmplifyDamageI = 
    { id = 0
    , level = 2
    , unlocked = False
    , desciption = "Skill: Amplify Damage I in subsystem Berserker"
    , name = "Amplify Damage I"
    }

skillShootingSkillII : Skill
skillShootingSkillII =
    { id = 0
    , level = 3
    , unlocked = False
    , desciption = "Skill: Shooting SKill II in subsystem Berserker"
    , name = "Shooting Skill II"
    }



skillAmplifyDamageII : Skill
skillAmplifyDamageII = 
    { id = 1
    , level = 3
    , unlocked = False
    , desciption = "Skill: Amplify Damage in subsystem Berserker"
    , name = "Amplify Damage II"
    }

skillBattleFervor : Skill
skillBattleFervor = 
    { id = 0
    , level = 4
    , unlocked = False
    , desciption = "Skill: Battle Fervor in subsystem Berserker"
    , name = "Battle Fervor"
    }

skillDualWield : Skill
skillDualWield = 
    { id = 1
    , level = 4
    , unlocked = False
    , desciption = "Skill: Dual Wield in subsystem Berserker"
    , name = "Dual Wield"
    }

subSysPhantom : SkillSubSystem
subSysPhantom = 
    { id = 0
    , skills = 
        [ skillSpeedUpI
        , skillMissI
        , skillSpeedUpII, skillMissII
        , skillFlash, skillInvisible
        ]
    , name = "Phantom"
    , chosen = (-1,-1)
    , text = ""
    , unlockLevel = 0
    }

subSysMechanic : SkillSubSystem
subSysMechanic = 
    { id = 1
    , skills = 
        [ skillArmorUpgradeI
        , skillArmorUpgradeII
        , skillMoreBullets, skillDirectionalBlasting
        , skillAbsoluteTerritoryField, skillExplosionIsArt
        ]
    , name = "Mechanic"
    , chosen = (-1,-1)
    , text = ""
    , unlockLevel = 0
    }

subSysBerserker : SkillSubSystem
subSysBerserker = 
    { id = 2
    , skills = 
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
defaultSubSystem = subSysPhantom

defaultSystem : SkillSystem
defaultSystem =
    { subsys = [subSysPhantom, subSysMechanic, subSysBerserker]
    , current = 0
    , points = 30
    , active = False
    }

skillState : Int -> Int -> Int -> List SkillSubSystem -> SkillSubSystem -> Skill -> Bool
skillState subId skillId skillLevel subsystems subSys skill =
    let
        bool = subsystems
              |> List.filter (\sub -> sub.id == subId)
              |> List.head
              |> Maybe.withDefault subSys
              |> .skills
              |> List.filter (\s -> s.id == skillId && s.level == skillLevel)
              |> List.head
              |> Maybe.withDefault skill
              |> .unlocked
    in
        bool