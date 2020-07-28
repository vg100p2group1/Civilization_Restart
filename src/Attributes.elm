module Attributes exposing (Attr, AttrInfo, AttrType(..), getAttrName, getMaxAttr, getCurrentAttr, setMaxAttr, setCurrentAttr, defaultAttr)

import Dict exposing (Dict, get,update)

type alias Attr = 
    { max : AttrInfo
    , current : AttrInfo
    }

defaultAttr : Attr
defaultAttr = {max = Dict.empty, current = Dict.empty}

-- it will only contain the attr that are adjusted
-- NOTE: it is quite annoying that Dict only provide get function for comparable types,
-- so instead of using a Dict AttrType, we have to use Dict Int Int and use a function
-- to convert AttrType into Int
type alias AttrInfo = Dict Int Int

type AttrType
    = Attack
    | Speed
    | Armor
    | Health
    | Clip      -- It acctually means total bullets but since the word Bullet is already used as a type, I chooce Clip instead
    | ShootSpeed

attrTypeToInt : AttrType -> Int
attrTypeToInt at = 
    case at of 
        Attack -> 0
        Speed -> 1
        Armor -> 2
        Health -> 3
        Clip -> 4
        ShootSpeed -> 5

getDefault : AttrType -> Int
getDefault at =
    case at of
        Attack -> 40
        Speed -> 30
        Armor -> 500
        Health -> 1000
        Clip -> 80
        ShootSpeed -> 40

getAttrName : AttrType -> String
getAttrName at = 
    case at of
        Attack -> "Attack"
        Speed -> "Speed"
        Armor -> "Armor"
        Health -> "Health"
        Clip -> "Bullet"
        ShootSpeed -> "Shooting Speed"

getAttr : AttrType -> AttrInfo -> Int
getAttr t pAttr =
    let
        stored = get (attrTypeToInt t) pAttr
    in
    case stored of
        Nothing -> getDefault t
        Just val -> val

setAttr : AttrType -> Int -> AttrInfo -> AttrInfo
setAttr at delta pAttr =
    let
        code = attrTypeToInt at
        change val = 
            case val of
                Nothing -> Just (delta + getDefault at)
                Just n -> Just (n + delta)
    in
    update code change pAttr

getMaxAttr : AttrType -> Attr -> Int
getMaxAttr aType attr =
    getAttr aType attr.max

getCurrentAttr : AttrType -> Attr -> Int
getCurrentAttr aType attr =
    getAttr aType attr.current

setMaxAttr : AttrType -> Int -> Attr -> Attr
setMaxAttr aType val attr =
    {attr|max = setAttr aType val attr.max}

setCurrentAttr : AttrType -> Int -> Attr -> Attr
setCurrentAttr aType val attr =
    {attr|current = setAttr aType val attr.current}