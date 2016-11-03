module Item.Factory
    exposing
        ( ItemFactory
        , init
        , make
        , makeReducer
        )

import Utils.IdGenerator as IdGenerator exposing (IdGenerator)
import Item.Item as Item exposing (Item)


type ItemFactory
    = A Model


type alias Model =
    { idGenerator : IdGenerator
    }


init : ItemFactory
init =
    { idGenerator = IdGenerator.init
    }
        |> A


make : Item.ItemType -> ItemFactory -> ( Item, ItemFactory )
make itemType (A model) =
    let
        ( id, idGenerator_ ) =
            IdGenerator.getUniqueId model.idGenerator
    in
        ( Item.new itemType id, A { model | idGenerator = idGenerator_ } )


makeReducer : Item.ItemType -> ( List Item, ItemFactory ) -> ( List Item, ItemFactory )
makeReducer itemType ( currentItems, itemFactory ) =
    let
        ( newItem, newItemFactory ) =
            make itemType itemFactory
    in
        ( newItem :: currentItems, newItemFactory )
