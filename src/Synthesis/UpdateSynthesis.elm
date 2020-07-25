module Synthesis.UpdateSynthesis exposing (updateSynthesis)
import Messages exposing (SynthesisMsg(..))
import Weapon exposing (defaultWeapon)
import Model exposing (GameState(..),Model)
import Synthesis.WeaponUpgrade exposing (weaponUpgrade)
updateSynthesis : SynthesisMsg -> Model -> (Model, Cmd msg)
updateSynthesis msg model =
    let
        me = model.myself
        weapon = me.weapons
        package = me.package
        sys = me.synthesis
        -- d1 = Debug.log "package" package
    in
        case msg of               
            TriggerSynthesisWindow ->
                let
                    sysNew = {sys| active = not sys.active,tip=""}
                    newMe = {me|synthesis = sysNew}
                    newModel =
                        if model.paused then
                                {model|myself = newMe, paused = not model.paused, gameState = Playing}
                            else
                                {model|myself = newMe, paused = not model.paused, gameState = Paused}
                in
                    (newModel,Cmd.none)
            NextWeapon next ->
                let -- true for next,false for previous
                    
                    getNext=
                        if next then
                            if sys.weaponNumber+1 ==4 then 
                                {sys|weaponNumber = 0}
                            else 
                                {sys|weaponNumber = sys.weaponNumber+1}
                        else 
                            if sys.weaponNumber ==0 then
                                {sys|weaponNumber = 3}
                            else
                                {sys|weaponNumber = sys.weaponNumber-1} 
                    
                in
                      ({model|myself={me|synthesis=getNext}},Cmd.none)
            Synthesis ->
                let
                    weaponNum = me.synthesis.weaponNumber
                    weaponHead = List.take weaponNum weapon 
                    weaponNowTemp = List.head <| List.drop weaponNum weapon 
                    weaponNow = 
                        case weaponNowTemp of 
                            Just a ->
                                a
                            _ ->
                                defaultWeapon
                    (weaponUpgraded,packageNew,tip) = weaponUpgrade weaponNow package
                    newWeapon = weaponHead ++ [weaponUpgraded] ++   List.drop (weaponNum+1) weapon       
                    synthesisSub = me.synthesis

                    newMe = {me|synthesis={synthesisSub|tip = tip},weapons=newWeapon,package=packageNew}

                in  
                    ({model|myself=newMe},Cmd.none)