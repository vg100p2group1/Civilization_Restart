module Synthesis.Material exposing (Material,WeaponMaterial,MaterialNeeded,bulletNeeded,weaponMaterial)
type alias Material =
    { steel : Int   
    , copper : Int 
    , wolfram : Int 
    , uranium  : Int 
    }

type alias MaterialNeeded =
    { level1 : Material
    , level2 : Material
    , level3 : Material 
    , level4 : Material 
    }

type alias WeaponMaterial =
    { pistol : MaterialNeeded
    , gatling : MaterialNeeded
    , mortar : MaterialNeeded
    , shotgun : MaterialNeeded
    }

pistolNeeded : MaterialNeeded 
pistolNeeded = 
    { level1 = Material 2 2 2 2
    , level2 = Material 4 4 4 4
    , level3 = Material 6 6 6 6
    , level4 = Material 8 8 8 8
    }

gatlingNeeded : MaterialNeeded 
gatlingNeeded = 
    { level1 = Material 4 4 2 2
    , level2 = Material 8 6 4 4
    , level3 = Material 12 8 4 4
    , level4 = Material 15 10 6 6
    }

motarNeeded : MaterialNeeded 
motarNeeded = 
    { level1 = Material 4 4 6 6
    , level2 = Material 8 8 10 10
    , level3 = Material 8 8 12 12
    , level4 = Material 10 10 15 15
    }

shotgunNeeded : MaterialNeeded 
shotgunNeeded = 
    { level1 = Material 2 6 6 4
    , level2 = Material 4 8 6 6
    , level3 = Material 4 10 8 6
    , level4 = Material 6 15 8 6
    }

bulletNeeded : Material 
bulletNeeded = Material 1 1 1 1

weaponMaterial : WeaponMaterial
weaponMaterial = WeaponMaterial pistolNeeded gatlingNeeded motarNeeded shotgunNeeded