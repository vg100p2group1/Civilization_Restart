module Messages exposing (Msg(..), SkillMsg(..),SynthesisMsg(..))
import Css exposing (Resize)
import Browser.Dom exposing (Viewport)
-- import Model exposing (MouseMoveData)
type Msg
    = Tick Float
    | MoveLeft Bool
    | MoveRight Bool
    | MoveUp Bool
    | MoveDown Bool
    | MouseMove (Float,Float)
    | MouseDown
    | MouseUp
    -- | Map
    | NextFloor
    | Resize Int Int
    | GetViewport Viewport
    | SkillChange SkillMsg
    | Noop
    -- for testing
    | ShowDialogue
    | NextSentence
    | ChangeWeapon Int
    | ChangeWeapon_
    | Start
    | Pause
    | Resume
    | ChangeGameState
    -- Weapon
    | SynthesisSystem SynthesisMsg
    
type SkillMsg
    = TriggerSkillWindow
    | SubSystemChange Bool      -- Ture for next page and False for last page
    | ChooseSkill Int Int       -- When Skill at (id, Level) is chosen
    | UnlockSkill

type SynthesisMsg
    = TriggerSynthesisWindow
    | NextWeapon Bool      
    | Synthesis        