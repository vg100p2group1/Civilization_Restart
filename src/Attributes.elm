module Attributes exposing (PlayerAttr, AttrType(..), getAttr, setAttr)

import Dict exposing (Dict, get,update)

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

attrTypeToInt : AttrType -> Int
attrTypeToInt at = 
    case at of 
        Attack -> 0
        Speed -> 1
        Armor -> 2
        Health -> 3
        Clip -> 4

getDefault : AttrType -> Int
getDefault at =
    case at of
        Attack -> 10
        Speed -> 10
        Armor -> 50
        Health -> 100
        Clip -> 80

getAttr : AttrType -> PlayerAttr -> Int
getAttr t pAttr =
    let
        stored = get (attrTypeToInt t) pAttr
    in
    case stored of
        Nothing -> getDefault t
        Just val -> val

setAttr : AttrType -> Int -> PlayerAttr -> PlayerAttr
setAttr at delta pAttr =
    let
        code = attrTypeToInt at
        change val = 
            case val of
                Nothing -> Just (delta + getDefault at)
                Just n -> Just (n + delta)
    in
    update code change pAttr