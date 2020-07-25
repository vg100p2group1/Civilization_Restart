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
    { level1 = Material 1 1 1 1
    , level2 = Material 1 1 1 1
    , level3 = Material 1 1 1 1
    , level4 = Material 1 1 1 1
    }

gatlingNeeded : MaterialNeeded 
gatlingNeeded = 
    { level1 = Material 1 1 1 1
    , level2 = Material 1 1 1 1
    , level3 = Material 1 1 1 1
    , level4 = Material 1 1 1 1
    }

motarNeeded : MaterialNeeded 
motarNeeded = 
    { level1 = Material 1 1 1 1
    , level2 = Material 1 1 1 1
    , level3 = Material 1 1 1 1
    , level4 = Material 1 1 1 1
    }

shotgunNeeded : MaterialNeeded 
shotgunNeeded = 
    { level1 = Material 1 1 1 1
    , level2 = Material 1 1 1 1
    , level3 = Material 1 1 1 1
    , level4 = Material 1 1 1 1
    }

bulletNeeded : Material 
bulletNeeded = Material 1 1 1 1

weaponMaterial : WeaponMaterial
weaponMaterial = WeaponMaterial pistolNeeded gatlingNeeded motarNeeded shotgunNeeded