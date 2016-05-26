module GameData.ASCIIMaps exposing (..)

{-| Holds all static map data:
- ASCII maps for each area
- Buildings, their location and purpose (inventory) for each area
-}

import GameData.Tile exposing (..)
import Game.Data exposing (..)


getASCIIMap : Area -> List String
getASCIIMap area =
    case area of
        Village ->
            villageMap

        Farm ->
            farmMap

        DungeonLevelOne ->
            dungeonLevelOneMap

        _ ->
            []


villageMap : List String
villageMap =
    [ "========,,###,,,========"
    , "========,,,.,,,,========"
    , "========,,,.,,,,========"
    , "========,,,.,,,,========"
    , "========,,,.,,,,========"
    , "===,,,,,;...,,,!###====="
    , "===###!;.;,.,,;.###====="
    , "===###..;,,.,;.;###====="
    , "===###,,,,,...;,,,,,,==="
    , "===,,,,,,,,.,,,,,,,,,==="
    , "====,,,,,,,.,,,,,,,,,==="
    , "====,,,,,,,.,,,,,,,,,==="
    , "====,,,,,,,.,!###,,,,==="
    , "====,,,##.....###,,,,==="
    , "====,,,##!,.,,###,,,,==="
    , "====,,,,,,,.,,,,,,,,,==="
    , "====,,,,,,,.,,,,,,,,,==="
    , "====,,###!...!###,======"
    , "====,,###..e..###,======"
    , "====,,###,...,###,======"
    , "====,,,,,,,.,,,,,,======"
    , "====,,,,,,,.!,,,,,======"
    , "======,,,#####,========="
    , "======,,,#####,========="
    , "======,,,#####,========="
    , "======,,,#####,========="
    , "======,,,#####,========="
    , "========================"
    ]


villageBuildings : List Building
villageBuildings =
    [ { name = "Village Gate"
      , tile = Gate_NS
      , entry = { x = 1, y = 0 }
      , pos = { x = 10, y = 0 }
      , size = { x = 3, y = 1 }
      }
    , { name = "Junk Shop"
      , tile = StrawHouse_EF
      , pos = { x = 3, y = 6 }
      , entry = { x = 2, y = 1 }
      , size = { x = 3, y = 3 }
      }
    , { name = "Private House"
      , tile = StrawHouse_WF
      , pos = { x = 16, y = 5 }
      , entry = { x = 2, y = 2 }
      , size = { x = 3, y = 3 }
      }
    , { name = "Potion Store"
      , tile = Hut_EF
      , pos = { x = 7, y = 13 }
      , entry = { x = 2, y = 1 }
      , size = { x = 3, y = 3 }
      }
    , { name = "Private House 2"
      , tile = StrawHouse_WF
      , pos = { x = 14, y = 12 }
      , entry = { x = 2, y = 2 }
      , size = { x = 3, y = 3 }
      }
    , { name = "Weapon Shop"
      , tile = StrawHouse_EF
      , pos = { x = 6, y = 17 }
      , entry = { x = 2, y = 1 }
      , size = { x = 3, y = 3 }
      }
    , { name = "General Store"
      , tile = StrawHouse_WF
      , pos = { x = 14, y = 17 }
      , entry = { x = 0, y = 1 }
      , size = { x = 3, y = 3 }
      }
    , { name = "Odin's Temple"
      , tile = HutTemple_NF
      , pos = { x = 9, y = 22 }
      , entry = { x = 2, y = 0 }
      , size = { x = 5, y = 5 }
      }
    ]


farmMap : List String
farmMap =
    [ "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^^^^^^^^#^^^^^^^^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^^^^^^^^.^^^^^^^^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^^^^^^^^.,,,^^^^^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^^^^^^,,.,,,,,^^^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^,,,,,,,.,,,,,,^^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^,,,,,,,,.,,,,,,,,,^^^^^^^^^^^^^^^"
    , ",,,,,,,,,,,,,,,,,,,,,,,,.,,,,,,,,,,,,,,,,,,,,,,,,"
    , ",,,,,,,,,,,,,,,,,,,,,,,,.,,,,,,,,,,,,,,,,,,,,,,,,"
    , ",,,,,,,,,,,,,,,,,,,,,,,,.,,,,,,,,,,,,,,,,,,,,,,,,"
    , ",,,,,,,,,,,,,,,,,,,,,,,,.,,,,,,,,,,,,,,,,,,,,,,,,"
    , ",,,,,,,,,,,,,,,,,,,,,,,,.,,,,,,,,,,,,,,,,,,,,,,,,"
    , ",,,,,,,,,,,,,,,,,,,,,,,,.,,,,,,,,,,,,,,,,,,,,,,,,"
    , ",,,,,,,,,,,,,,,,,,,,,,,,.,,,,,,,,,,,,,,,,,,,,,,,,"
    , ",,,,,,,,,,,,,,,,,,,,,,,,.,,,,,,,,,,,,,,,,,,,,,,,,"
    , "................................................."
    , "................................................."
    , ",,,,,,,,,,,,,,,,,,,,,,,..;,,,,,,,,,,,,,,,,,,,,,,,"
    , ",,,,,,,,,,,,,,,,,,,,,,;.;,,,,,,,,,,,,,,,,,,,,,,,,"
    , ",,,,,,,,,,,,,,,,,,,,,;.;,,,,,,,,,,,,,,,,,,,,,,,,="
    , ",,,,,,,,,,,,,,,,,,,,;.;,,,,,,,,,,,,,,,,,,,,,,,,,="
    , ",,,,,,,,,,,,,,,,,,,;.;,,,,,,,,,,,,,,,,,,,,,,,,,,="
    , ",,,,,,,,,,,,,,,,,,;.;,,,,,,,,,,,,,,,,,,,,,,,,,,,="
    , ",,,,,,,,,,,,,,,,,;.;,,,,,,,,,,,,,,,,,,,,,,,###,,="
    , ",,,,,,,,,,,,,,,,;..........................###,,="
    , ",,,,,,,,,,,,,,,;.;,,,,,,,,,,,,,,,,,,,,,,,,,###,,="
    , ",,,,,,,,,,,,,,;.;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,="
    , ",,,,,,,,,,,,,;.;,,,,,,,,,,,,,,,,,,,,,,,,,,======="
    , ",,,,,,,,,,,,;.;,,,,,,,,,,,,,,,,,,,,,,,,,,,======="
    , "========,,,;.;,,,,,,,,,,,,,,,,,,,,,,,,,,,,======="
    , "========,,,.;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,======="
    , "========,,,.,,,,,=======,,,,,,,,,,,,,,,,,,======="
    , "========,,###,,,,=======,,,,,,,,,,,,,,,,,,,,,,,,,"
    ]


farmBuildings : List Building
farmBuildings =
    [ { name = "Farm Gate"
      , tile = Gate_NS
      , entry = { x = 1, y = 0 }
      , pos = { x = 10, y = 32 }
      , size = { x = 3, y = 1 }
      }
    , { name = "Adopted Parents House"
      , tile = StrawHouse_WF
      , pos = { x = 43, y = 23 }
      , entry = { x = 2, y = 1 }
      , size = { x = 3, y = 3 }
      }
    , { name = "Mine Entrance"
      , tile = MineEntrance
      , pos = { x = 24, y = 1 }
      , entry = { x = 0, y = 0 }
      , size = { x = 1, y = 1 }
      }
    ]


dungeonLevelOneMap : List String
dungeonLevelOneMap =
    [ "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^^^dooo^^ood^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^doooooddooo^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^doddoooooooo^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^dod^^oooo^ooo^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^od^^^oooo^ooo^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^o^^^^dooo^ooo^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^o^^^^^dod^dod^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^od^^^^^^^^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^dod^^^^^^^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^dod^^^^^^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^do^^^^^^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^^o^^^^^^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^^od^^^^^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^^dod^^^^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^^^dod^^^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^^^^dod^^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^^^^^do^^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^dood^^^^^^o^^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^ooood^^^^^o^^^^^^^^^^doood^^^"
    , "^^^^^^^^^^^^oooooo^^^^o^^^^^^^^^^ooooo^^^"
    , "^^^^^^^^^^^^dooooo^^^^o^^^^^^^^^^ooooo^^^"
    , "^^^^^^^^^^^^^o^^^^^^^^o^^^^^^^^^dooooo^^^"
    , "^^^^^^^^^^^^^o^^^^^^^^o^^^^^dooooooooo^^^"
    , "^^^^^^^^^^^^^o^^^^^^^^o^^^^dod^^^doooo^^^"
    , "^^^^^^^^^^^^^od^^^^^^^od^^dod^^^^^^^oo^^^"
    , "^^^^^^^^^^^^^dod^^^^^^doddod^^^^^^^ood^^^"
    , "^^^^^^^^^^^^^^dod^^^^^^dood^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^do^^^^^^^o^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^od^^^^^^o^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^dod^^^^^o^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^dod^^^do^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^^dod^^od^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^^^doddo^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^^^^dood^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^^^^^do^^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^^^^^^o^^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^^^^^^o^^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^^^^^^o^^^^^^^^^^^^^^^^^^"
    , "^^^^^^^^^^^^^^^^^^^^^^.^^^^^^^^^^^^^^^^^^"
    ]
