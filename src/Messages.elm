module Messages exposing (Msg(..))
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

    -- for testing
    | ShowDialogue
    | NextSentence