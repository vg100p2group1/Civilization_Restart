module UpdateSkill exposing (updateSkill)

import Skill exposing (SkillSubSystem,switchSubSystem, choose, unlockChosen, getCurrentSubSystem)
import Model exposing (Model, GameState(..))
import Messages exposing (Msg, SkillMsg(..))
import Attributes exposing (Attr, AttrType(..), setCurrentAttr, setMaxAttr)

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
                attr = model.myself.attr
                (finalSub, points, newAttr) = 
                    if cost > sys.points then     -- only apply if player can afford it
                        ({sub|text ="it requires more points than you have"}, sys.points, attr)
                    else
                        (newSub, sys.points - cost, attr)
                newSubList = List.take sys.current subList ++ finalSub :: List.drop (sys.current+1) subList
                newSys = {sys|subsys = newSubList, points = points}
                newMe = {me|skillSys = newSys, attr = newAttr}
                newModel = {model|myself = newMe}
            in
                (newModel, Cmd.none)

atUnlock : SkillSubSystem -> Attr -> Attr
atUnlock sub attr =
    -- find out what skill is unlocked
    let
        subId =  Debug.log "at unlock" sub.id
        id = Debug.log "at unlock" (Tuple.first sub.chosen)
        level = Debug.log "at unlock" (Tuple.second sub.chosen)
    in
    case subId of
        0 ->    -- Phantom
            case level of
                1 ->    -- Speed Up I
                    setCurrentAttr Speed 20 attr
                    |> setMaxAttr Speed 20
                _-> attr

        1 ->    -- Mechanic
            attr
        2 ->    -- Berserker
            Debug.log "emmm" (case level of
                1 ->    -- Shooting Skill I
                    Debug.log "attr" (setCurrentAttr ShootSpeed 30 attr
                    |> setMaxAttr ShootSpeed 30)
                2 ->    -- Amplify Damage I
                    setCurrentAttr Attack 200 attr
                    |> setMaxAttr Attack 200
                3 -> 
                    if id == 0 then -- Shooting SKill II
                        setCurrentAttr ShootSpeed 35 attr
                        |> setMaxAttr ShootSpeed 35
                    else    -- Amplify Damage II
                        setCurrentAttr Attack 30 attr
                        |> setMaxAttr Attack 30
                4 -> -- Skills in level 4 does not change attributes
                    attr
                _ ->
                    attr)
        _-> attr