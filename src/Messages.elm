module Messages exposing (Msg(..))
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
    | Noop
    | Resize Int Int
    | GetViewport Viewport
    -- for testing
    | ShowDialogue
    | NextSentence
    | ChangeWeapon Int
    | ChangeWeapon_


