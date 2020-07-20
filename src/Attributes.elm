module Attributes exposing (PlayerAttr, AttrType(..))

import Dict exposing (Dict, fromList)

-- it will only contain the attr that are adjusted
-- NOTE: it is quire annoying that Dict only provide get function for comparable types,
-- so instead of using a Dict AttrType, we have to use Dict Int Int and use a function
-- to convert AttrType into Int
type alias PlayerAttr = Dict Int Int

type AttrType
    = Attack
    | Speed
    | Armor
    | Health
    | Clip      -- It acctually means total bullets but since the word Bullet is already used as a type, I chooce Clip instead