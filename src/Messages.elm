
module Messages exposing (Msg(..), SkillMsg(..),SynthesisMsg(..),ShiftMsg(..),WeaponChoosingMsg(..),PageMsg(..))
import Css exposing (Resize)
import Browser.Dom exposing (Viewport)
import Time exposing (Posix)
import Weapon exposing (Arsenal(..))
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
    | FMsg
    | Resize Int Int
    | GetViewport Viewport
    | SkillChange SkillMsg
    | Noop
    -- for testing
    | ShowDialogue
    | NextSentence
    | ChangeWeapon_ Int
    | ChangeWeapon ShiftMsg
    | Start
    | Pause
    | Resume
    | ChangeGameState
    -- Weapon
    | SynthesisSystem SynthesisMsg
    | DualWield
    | Flash
    | ATField
    | Invisibility
    | Tictoc Time.Posix
    | PageChange PageMsg
    | WeaponChoosing WeaponChoosingMsg
    | UnlockTrigger

type ShiftMsg
    = Previous
    | Next

type SkillMsg
    = TriggerSkillWindow
    | SubSystemChange Bool      -- Ture for next page and False for last page
    | ChooseSkill Int Int       -- When Skill at (id, Level) is chosen
    | UnlockSkill

type SynthesisMsg
    = TriggerSynthesisWindow
    | NextWeapon Bool      
    | Synthesis        
    | SynthesisBullet


type PageMsg
    = Welcome
    | Help
    | Game
    | About
    | Story


type WeaponChoosingMsg
    = CloseWindow
    | ChoosingWeapon Arsenal
    | UnlockWeapon

