module Dungeon.Rooms.Diamond exposing (..)

{-|
    Diamond rooms looks like this with potential entrances on it's single flat wall
    and cornices around the flat wall.

    Diamonds have a minimum size of 5 and their dimensions must
    be the same odd number (x, x) to keep the diagonal walls straight.

    If given a even sized dimension, the last row or column
    will be left blank and treated as if it wasn't part of the room.
      0 2 4
    0".###."
     "#/.\#"
    2"#...#"
     "#\./#"
    4".###."

      0 2 4 6 8
    0"...###..."
     "..#/.\#.."
    2".#/...\#."
     "#/.....\#"
    4"#.......#"
     "#\...../#"
    6".#\.../#."
     "..#\./#.."
    8"...###..."

-}

import Dungeon.Rooms.Type exposing (..)
import Utils.Vector exposing (..)
import List exposing (map2, reverse)


template : RoomTemplate
template =
    { makeWalls = walls
    , makeCorners = corners
    , makeFloors = floors
    }


type alias Model =
    { size : RoomSize
    , mid : Int
    , max : Int
    }


type alias RoomSize =
    Int


{-| Diamons have 4 corners which are also the only walls that can support entrancess.
-}
walls : Dimension -> List Walls
walls dimension =
    let
        model =
            info dimension
    in
        [ [ ( 0, model.mid ) ]
        , [ ( model.max, model.mid ) ]
        , [ ( model.mid, 0 ) ]
        , [ ( model.mid, model.max ) ]
        ]


floors : Dimension -> Floors
floors dimension =
    let
        model =
            info dimension

        leftToTop =
            \x -> model.mid + 1 + x

        leftToBottom =
            \x -> model.mid - 1 - x

        topToRight =
            \x -> (-1 - model.mid) + x

        bottomToRight =
            \x -> (model.max + 1 + model.mid) - x

        floorsLeft =
            \x -> List.map ((,) x) <| List.range (leftToBottom x) (leftToTop x)

        floorsRight =
            \x -> List.map ((,) x) <| List.range (topToRight x) (bottomToRight x)

        zeroToMidX =
            List.range 0 (model.mid - 1)

        midToMaxX =
            List.range (model.mid + 1) model.max
    in
        List.concat
            [ -- x goes from left to middle(1 to mid - 1), y goes from middle up and down
              List.concat <| List.map floorsLeft zeroToMidX
            , -- x goes from middle to right (mid+1, max-1), y goes from zero to middle and max to middle
              List.concat <| List.map floorsRight midToMaxX
            , List.map ((,) model.mid) <| List.range 1 (model.max - 1)
            ]


{-| For a diagonal room, the corners are the diagonal walls. They cannot have entrances.
    To calculate the diagonal positions, picture a diamond on a cartesian plane
    with the diamond being in the +x, -y quadrant (screen coords)
-}
corners : Dimension -> Walls
corners dimension =
    let
        model =
            info dimension

        leftToTop =
            \x -> ( x, model.mid + 1 + x )

        leftToBottom =
            \x -> ( x, model.mid - 1 - x )

        topToRight =
            \x -> ( x, (-1 - model.mid) + x )

        bottomToRight =
            \x -> ( x, (model.max + 1 + model.mid) - x )

        zeroToMidX =
            List.range 0 (model.mid - 1)

        midToMaxX =
            List.range (model.mid + 1) model.max
    in
        List.concat
            [ -- x goes from left to middle(1 to mid - 1), y goes from middle up and down
              List.map leftToTop zeroToMidX
            , List.map leftToBottom zeroToMidX
              -- x goes from middle to right (mid+1, max-1), y goes from zero to middle and max to middle
            , List.map topToRight midToMaxX
            , List.map bottomToRight midToMaxX
            ]


info : Dimension -> Model
info dimension =
    let
        size =
            largestEquilaterialDimension dimension

        mid =
            size // 2

        max =
            size - 1
    in
        { size = size
        , mid = mid
        , max = max
        }


{-| Given a dimension (4, 7), work out the largest equilateral diamond that will fit in it.
    In the above case, it will be (3, 3) because diamonds have to be odd and same sided.
-}
largestEquilaterialDimension : Dimension -> RoomSize
largestEquilaterialDimension ( x, y ) =
    let
        ( x_, y_ ) =
            ( x - ((x + 1) % 2), y - ((y + 1) % 2) )

        smallestSide =
            min x_ y_
    in
        smallestSide
