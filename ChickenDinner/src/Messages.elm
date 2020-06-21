module Messages exposing (Msg(..))
type Msg
    = Tick Float
    | MoveLeft Bool
    | MoveRight Bool
    | MoveUp Bool
    | MoveDown Bool
    | Noop