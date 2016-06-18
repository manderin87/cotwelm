module Game.Data exposing (..)

import Hero exposing (..)
import GameData.Building exposing (..)
import Game.Maps exposing (..)
import Item.Item as Item exposing (..)
import Mouse exposing (Position)
import Equipment exposing (..)
import Container exposing (..)
import DragDrop exposing (..)
import IdGenerator exposing (..)


type alias Model =
    { name : String
    , hero : Hero
    , map : Game.Maps.Model
    , currentScreen : Screen
    , dnd : DragDrop Drag Drop
    , equipment : Equipment
    , idGen : IdGenerator
    }


type Drag
    = DragSlot Item EquipmentSlot
    | DragPack Item (Item.Pack Item)
    | DragShop Item


type Drop
    = DropPack (Item.Pack Item)
    | DropEquipment EquipmentSlot


type Screen
    = MapScreen
    | InventoryScreen
    | BuildingScreen Building


type Direction
    = Up
    | Down
    | Left
    | Right


type InventoryMsg source target
    = InventoryMsg
    | DnDMsg (DragDropMsg source target)


type Msg
    = KeyDir Direction
    | Map
    | Inventory
    | InvMsg (InventoryMsg Drag Drop)
    | NoOp
