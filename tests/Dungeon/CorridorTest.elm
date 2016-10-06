module Dungeon.CorridorTest exposing (all)

import Test exposing (..)
import Expect exposing (Expectation)
import Should exposing (..)
import Dungeon.Corridor as Corridor exposing (..)
import Tile exposing (..)
import Utils.Vector exposing (..)
import Utils.CompassDirection exposing (..)
import List.Extra exposing (find)


all : Test
all =
    describe "Dungeon.Corridors"
        [ create_corridor
        , start_and_end_points_are_drawn
        , add_points_to_corridor_draws_correct_path
        , horizontal_corridors_have_walls
        , diagonal_corridors_have_walls_too
        , diagonal_corridors_have_walls_that_bend_around_corners
        ]



-- Helpers


tilesContains : TileType -> Vectors -> Tiles -> Bool
tilesContains matchingTileType positions tiles =
    let
        sameAsMatchingTileType =
            Tile.tileType >> (==) matchingTileType

        paths =
            tiles
                |> List.filter sameAsMatchingTileType
                |> List.map Tile.position

        isPath pos =
            List.member pos paths
    in
        List.all isPath positions



-- Test


create_corridor : Test
create_corridor =
    let
        tiles =
            Corridor.init ( ( 5, 5 ), N )
                |> Corridor.add ( ( 5, 6 ), N )
                |> Corridor.toTiles

        floorTile =
            tileAtPosition Tile.DarkDgn ( 5, 5 ) tiles

        doorTile =
            tileAtPosition Tile.DoorClosed ( 5, 5 ) tiles
    in
        describe "creating a new corridor"
            [ it_should "have a single entry point that is a floor or a door" (floorTile || doorTile)
            ]


start_and_end_points_are_drawn : Test
start_and_end_points_are_drawn =
    let
        tiles =
            Corridor.init ( ( 3, 3 ), N )
                |> Corridor.add ( ( 10, 3 ), S )
                |> Corridor.toTiles

        expectedBeginFloorTiles =
            [ ( 3, 3 ) ]

        expectedEndFloorTiles =
            [ ( 10, 3 ) ]
    in
        describe "start and end tiles are being drawn"
            [ it_should "have a start floor tile" (tilesContains Tile.DarkDgn expectedBeginFloorTiles tiles)
            , it_should "have a end floot tile" (tilesContains Tile.DarkDgn expectedEndFloorTiles tiles)
            ]


add_points_to_corridor_draws_correct_path : Test
add_points_to_corridor_draws_correct_path =
    let
        corridor =
            Corridor.init ( ( 5, 5 ), N )

        corridor7 =
            Corridor.add ( ( 7, 7 ), S ) corridor

        tiles10 =
            Corridor.add ( ( 7, 10 ), S ) corridor7
                |> Corridor.toTiles

        tiles7 =
            Corridor.toTiles corridor7

        -- we leave out the start/end as they may not be paths
        expectedTiles7 =
            [ ( 6, 6 ), ( 7, 7 ) ]

        expectedTiles10 =
            expectedTiles7 ++ [ ( 7, 8 ), ( 7, 9 ) ]

        invalidTiles =
            [ ( 1, 10 ), ( 50, 50 ) ]
    in
        describe "adding points to path"
            [ it_should "create a path between (5, 5) and (7, 7)" (tilesContains Tile.DarkDgn expectedTiles7 tiles7)
            , it_should "create a path between (5, 5), (7, 7) and (7, 10)" (tilesContains Tile.DarkDgn expectedTiles10 tiles10)
            , it_should_not "contain paths for invalid tiles" (tilesContains Tile.DarkDgn invalidTiles tiles10)
            ]


horizontal_corridors_have_walls : Test
horizontal_corridors_have_walls =
    let
        tiles =
            Corridor.init ( ( 10, 10 ), E )
                |> Corridor.add ( ( 8, 10 ), S )
                |> Corridor.toTiles

        walls =
            [ ( 10, 9 )
            , ( 9, 9 )
            , ( 8, 9 )
            , ( 10, 11 )
            , ( 9, 11 )
            , ( 8, 11 )
            ]
    in
        describe "a horizontal length corridor"
            [ it_should "be lined with walls on the top/bottom" (tilesContains Tile.Rock walls tiles)
            ]


{-|

A diagonal corridor should look something like this with points at (2, 0) and (5, 3).
The facing and corners will affect walls neighbouring the two end points so only test for the middle two
points.


  \ \
2  \ \
    \ \
0    \ \
 0 2 4 6
# - walls
\ - half walls


-}
diagonal_corridors_have_walls_too : Test
diagonal_corridors_have_walls_too =
    let
        tiles =
            Corridor.init ( ( 5, 0 ), S )
                |> Corridor.add ( ( 2, 3 ), W )
                |> Corridor.complete
                |> Corridor.toTiles

        pathWalls =
            [ ( 3, 1 ), ( 5, 1 ) ]
                ++ [ ( 2, 2 ), ( 4, 2 ) ]

        diagonalHalfRocks =
            tilesContains Tile.WallDarkDgn pathWalls tiles
    in
        it_should ("have diagonal half rocks expected: " ++ toString pathWalls) diagonalHalfRocks


{-|

When a corridor turns at a corner, make sure there are walls that encircle around the turn.
Disregard x=0 because that's part of the room

 ####
3D \##
 #\ \##
1##\ \##
 ###\ \#
 0 2 4 6
# - walls
\ - half walls
D - door of a room, unrelated
< - Westward facing corridor at (1, 1)

-}
diagonal_corridors_have_walls_that_bend_around_corners : Test
diagonal_corridors_have_walls_that_bend_around_corners =
    let
        tiles =
            Corridor.init ( ( 4, 0 ), S )
                |> Corridor.add ( ( 1, 3 ), W )
                |> Corridor.complete
                |> Corridor.toTiles

        expectedWalls =
            [ ( 1, 4 ) ]
    in
        describe "when a NW diagonal corridors hits a W room"
            [ it_should "have a full wall to the N, i.e at (1, 1)"
                <| tilesContains Tile.Rock expectedWalls tiles
            ]



------------------
-- Test helpers --
------------------


tileAtPosition : TileType -> Vector -> Tiles -> Bool
tileAtPosition tileType pos tiles =
    let
        atPosition tile =
            Tile.position tile == pos
    in
        case find atPosition tiles of
            Nothing ->
                False

            Just tile ->
                tileType == Tile.tileType tile
