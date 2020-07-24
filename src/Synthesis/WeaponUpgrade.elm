module Synthesis.WeaponUpgrade exposing (weaponUpgrade)
import Synthesis.Material exposing (Material, weaponMaterial)
import Synthesis.Package exposing (Package)
import Weapon exposing (Weapon,Arsenal(..))

weaponUpgrade : Weapon -> Package -> (Weapon,Package,String)
weaponUpgrade weapon package=
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
        getWeaponMaterial=
            case weapon.extraInfo of
                Pistol ->
                    getLevel weaponMaterial.pistol
                Gatling ->
                    getLevel weaponMaterial.gatling
                Mortar ->
                    getLevel weaponMaterial.mortar
                Shotgun ->
                    getLevel weaponMaterial.shotgun
        materialNeeded = getWeaponMaterial 
        newPackage = Package (package.steel - materialNeeded.steel) (package.copper - materialNeeded.copper) (package.wolfram - materialNeeded.wolfram) (package.uranium - materialNeeded.uranium) 
 
        upgradeGun =
            if materialNeeded ==  Material 0 0 0 0 then 
                (weapon,package,"Fail,Higheset Level")
            else  if package.steel > getWeaponMaterial.steel && package.copper > getWeaponMaterial.copper 
                    && package.wolfram > getWeaponMaterial.wolfram && package.uranium > getWeaponMaterial.uranium then
                (weapon, newPackage,"Success")
            else 
                (weapon,package,"Fail,Not Enough Material")

    in
        upgradeGun