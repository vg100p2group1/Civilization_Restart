module UpdateSkill exposing (updateSkill)

import Skill exposing (SubSystem,switchSubSystem, choose, unlockChosen, getCurrentSubSystem)
import Model exposing (Model, GameState(..))
import Messages exposing (Msg, SkillMsg(..))
import Attributes exposing (Attributes, setCurrentAttr)

updateSkill : SkillMsg -> Model -> (Model, Cmd Msg)
updateSkill msg model =
    let
        me = model.myself
        sys = me.skillSys
    in
    case msg of
        TriggerSkillWindow->
            let 
                active = sys.active
                subList = sys.subsys
                newSub = List.map (\sub -> choose sub (0,0)) subList
                newSys = {sys|active = not active, subsys = newSub}
                newMe = {me|skillSys = newSys}
                newModel =
                    if model.paused then
                        {model|myself = newMe, paused = not model.paused, gameState = Playing}
                    else
                        {model|myself = newMe, paused = not model.paused, gameState = Paused}
            in
                (newModel, Cmd.none)
        SubSystemChange change ->
            let 
                delta = if change then 1 else -1
                newSys = switchSubSystem sys delta
                newMe = {me|skillSys = newSys}
                newModel = {model|myself = newMe}
            in
                (newModel, Cmd.none)
        ChooseSkill id level->
            let 
                sub = getCurrentSubSystem sys
                subList = sys.subsys
                newSub = choose sub (id, level)
                newSubList = List.take sys.current subList ++ newSub :: List.drop (sys.current+1) subList
                newSys = {sys|subsys = newSubList}
                newMe = {me|skillSys = newSys}
                newModel = {model|myself = newMe}
            in
                (newModel, Cmd.none)
        UnlockSkill ->
            let
                sub = getCurrentSubSystem sys
                subList = sys.subsys
                (newSub,cost) = unlockChosen sub
                (finalSub, points) = 
                    if cost > sys.points then     -- only apply if player can afford it
                        ({sub|text ="it requires more points than you have"}, sys.points)
                    else
                        (newSub, sys.points - cost)
                newSubList = List.take sys.current subList ++ finalSub :: List.drop (sys.current+1) subList
                newSys = {sys|subsys = newSubList, points = points}
                newMe = {me|skillSys = newSys}
                newModel = {model|myself = newMe}
            in
                (newModel, Cmd.none)

atUnlock : SubSystem -> Attribute -> (SubSystem, Attribute)
atUnlock sub attr =
    -- find out what skill is unlocked
    (sub, attr)