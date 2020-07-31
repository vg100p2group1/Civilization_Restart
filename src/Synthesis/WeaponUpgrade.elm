module Synthesis.WeaponUpgrade exposing (weaponUpgrade,getWeaponMaterial,bulletSynthesis)
import Synthesis.Material exposing (Material, weaponMaterial,bulletNeeded)
import Synthesis.Package exposing (Package)
import Weapon exposing (Weapon,Arsenal(..))
import Attributes exposing (Attr,AttrType(..),setCurrentAttr)

weaponUpgrade : Weapon -> Package -> (Weapon,Package,String)
weaponUpgrade weapon package=
    let

        materialNeeded = getWeaponMaterial weapon
        newPackage = Package (package.steel - materialNeeded.steel) (package.copper - materialNeeded.copper) (package.wolfram - materialNeeded.wolfram) (package.uranium - materialNeeded.uranium) 
 
        upgradeGun =
            if materialNeeded ==  Material 0 0 0 0 then 
                (weapon,package,"Fail,Higheset Level")
            else  if package.steel >= materialNeeded.steel && package.copper >= materialNeeded.copper 
                    && package.wolfram >= materialNeeded.wolfram && package.uranium >= materialNeeded.uranium then
                ({weapon|level=weapon.level+1}, newPackage,"Success")
            else 
                (weapon,package,"Fail,No Enough Material")
    in
        upgradeGun

bulletSynthesis : Attr -> Package -> (Attr,Package,String)
bulletSynthesis attr package=
    let

        materialNeeded = bulletNeeded
        newPackage = Package (package.steel - materialNeeded.steel) (package.copper - materialNeeded.copper) (package.wolfram - materialNeeded.wolfram) (package.uranium - materialNeeded.uranium) 
        newAttr = setCurrentAttr Clip 30 attr
        synthesis =
            if package.steel >= materialNeeded.steel && package.copper >= materialNeeded.copper 
                    && package.wolfram >= materialNeeded.wolfram && package.uranium >= materialNeeded.uranium then
                (newAttr, newPackage,"Success")
            else 
                (attr,package,"Fail,No Enough Material")
    in
        synthesis


getWeaponMaterial : Weapon -> Material
getWeaponMaterial weapon =
    let
        getLevel model= 
            case weapon.level of 
                1->
                    model.level1
                2->
                    model.level2
                3->
                    model.level3
                4->
                    model.level4
                _-> 
                    Material 0 0 0 0
    in
        case weapon.extraInfo of
            Pistol ->
                getLevel weaponMaterial.pistol
            Gatling ->
                getLevel weaponMaterial.gatling
            Mortar ->
                getLevel weaponMaterial.mortar
            Shotgun ->
                getLevel weaponMaterial.shotgun
            NoWeapon ->
                getLevel weaponMaterial.shotgun