module Item.Item
    exposing
        ( Item(..)
        , Weapon
        , Armour
        , Shield
        , Helmet
        , Bracers
        , Gauntlets
        , Belt
        , Pack
        , Purse
        , Neckwear
        , Overgarment
        , Ring
        , Boots
        , new
        , newFoldableItem
        , ItemType(..)
        , view
        , viewSlot
          -- item functions
        , isCursed
        , toPurse
        , priceOf
        , costOf
          -- pack functions
        , addToPack
        , removeFromPack
        , packInfo
        , packContents
          -- comparisons
        , equals
        )

import Html exposing (..)
import Html.Attributes exposing (..)
import Container exposing (Container)


-- utils

import Utils.Mass as Mass exposing (..)
import Utils.IdGenerator as IdGenerator exposing (..)


-- sub items

import Item.Data exposing (..)
import Item.TypeDef exposing (..)
import Item.Weapon exposing (..)
import Item.Armour exposing (..)
import Item.Shield exposing (..)
import Item.Helmet exposing (..)
import Item.Bracers exposing (..)
import Item.Gauntlets exposing (..)
import Item.Belt exposing (..)
import Item.Pack exposing (..)
import Item.Purse exposing (..)


{-
   import Item.Purse exposing (..)
      import Item.Neckwear exposing (..)
      import Item.Overgarment exposing (..)
      import Item.Ring exposing (..)
      import Item.Boots exposing (..)
-}


type alias Weapon =
    Item.Weapon.Weapon


type alias Armour =
    Item.Armour.Armour


type alias Shield =
    Item.Shield.Shield


type alias Helmet =
    Item.Helmet.Helmet


type alias Bracers =
    Item.Bracers.Bracers


type alias Gauntlets =
    Item.Gauntlets.Gauntlets


type alias Belt a =
    Item.Belt.Belt a


type alias Pack a =
    Item.Pack.Pack a


type alias Purse =
    Item.Purse.Purse



{- type alias Neckwear =
       Item.Neckwear.Neckwear


   type alias Overgarment =
       Item.Overgarment.Overgarment


   type alias Ring =
       Item.Ring.Ring


   type alias Boots =
       Item.Boots.Boots
-}


type alias ItemTypes =
    List ItemType


type ItemType
    = Weapon WeaponType
    | Armour ArmourType
    | Shield ShieldType
    | Helmet HelmetType
    | Bracers BracersType
    | Gauntlets GauntletsType
    | Belt BeltType
    | Pack PackType
    | Purse
    | Neckwear NeckwearType
    | Overgarment OvergarmentType
    | Ring RingType
    | Boots BootsType


type Item
    = ItemWeapon Weapon
    | ItemArmour Armour
    | ItemShield Shield
    | ItemHelmet Helmet
    | ItemBracers Bracers
    | ItemGauntlets Gauntlets
    | ItemBelt (Belt Item)
    | ItemPack (Pack Item)
    | ItemPurse Purse
    | ItemNeckwear Neckwear
    | ItemOvergarment Overgarment
    | ItemRing Ring
    | ItemBoots Boots


type Neckwear
    = NeckwearModelTag NeckwearType Model


type Overgarment
    = OvergarmentModelTag OvergarmentType Model


type Ring
    = RingModelTag RingType Model


type Boots
    = BootsModelTag BootsType Model



--------------------
-- Pack functions --
--------------------


addToPack : Item -> Pack Item -> ( Pack Item, Item.TypeDef.Msg )
addToPack item pack =
    let
        isItemThePack =
            equals item (ItemPack pack)

        ( container', msg ) =
            Container.add item packModel.container

        (PM packType model packModel) =
            pack

        _ =
            Debug.log "is item the pack: " isItemThePack
    in
        if isItemThePack == True then
            ( pack, NestedItem )
        else
            case msg of
                Container.Ok ->
                    ( PM packType model { packModel | container = container' }, Item.TypeDef.Ok )

                Container.MassMsg massMsg ->
                    ( pack, Item.TypeDef.MassMsg massMsg )


removeFromPack : a -> Pack a -> Pack a
removeFromPack item (PM packType model packModel) =
    PM packType model { packModel | container = Container.take item packModel.container }


{-| Get the current mass and mass capacity for the given pack
-}
packInfo : Pack a -> ( Mass, Mass )
packInfo (PM _ _ packModel) =
    ( Container.getMass packModel.container, Container.capacity packModel.container )


packContents : Pack a -> List a
packContents (PM _ _ packModel) =
    Container.list packModel.container



-----------
-- Purse --
-----------


toPurse : Item -> Maybe Purse
toPurse item =
    case item of
        ItemPurse purse ->
            Just purse

        _ ->
            Nothing


{-| The price that shops are willing to sell an Item for, the buy field
-}
priceOf : Item -> Int
priceOf item =
    .sell (getModel item)


{-| The price that shops are willing to buy an Item for, the sell field
-}
costOf : Item -> Int
costOf item =
    .buy (getModel item)



----------------------------------------------------------------------
---------------------------- Base items ------------------------------
----------------------------------------------------------------------


getMass : Item -> Mass
getMass item =
    let
        model =
            getModel item
    in
        model.mass


isCursed : Item -> Bool
isCursed item =
    let
        { status } =
            getModel item
    in
        case status of
            Cursed ->
                True

            _ ->
                False


getModel : Item -> Model
getModel item =
    case item of
        ItemWeapon (WM _ { baseItem }) ->
            baseItem

        ItemArmour (A _ { baseItem }) ->
            baseItem

        ItemShield (ShieldM _ { baseItem }) ->
            baseItem

        ItemHelmet (HelmetM _ { baseItem }) ->
            baseItem

        ItemBracers (BracersM _ { baseItem }) ->
            baseItem

        ItemGauntlets (GauntletsM _ { baseItem }) ->
            baseItem

        ItemBelt (BeltModelTag _ model _) ->
            model

        ItemPack (PM _ model _) ->
            model

        ItemPurse (PurseM { baseItem }) ->
            baseItem

        ItemNeckwear (NeckwearModelTag _ model) ->
            model

        ItemOvergarment (OvergarmentModelTag _ model) ->
            model

        ItemRing (RingModelTag _ model) ->
            model

        ItemBoots (BootsModelTag _ model) ->
            model


equals : Item -> Item -> Bool
equals a b =
    let
        modelA =
            getModel a

        modelB =
            getModel b
    in
        IdGenerator.equals modelA.id modelB.id


view : Item -> Html msg
view item =
    viewSlot item ""


viewSlot : Item -> String -> Html msg
viewSlot item extraContent =
    let
        model =
            getModel item
    in
        div [ class "card" ]
            [ div
                {- [ class "ui item"
                   , style
                       [ ( "opacity", "1" )
                       , ( "cursor", "move" )
                       , ( "width", "32px" )
                       , ( "height", "64px" )
                       ]
                   ]
                -}
                []
                [ div [ class "image" ]
                    [ i [ class ("cotwItem " ++ model.css) ] []
                    ]
                , div [ class "content" ]
                    [ a [ class "header" ]
                        [ text model.name
                        ]
                    , div [ class "meta" ]
                        [ span [ class "date" ] [ text "" ]
                        ]
                    , div [ class "description", style [ ( "maxWidth", "7em" ) ] ]
                        [ text ""
                        ]
                    ]
                , div [ class "extra content" ] [ text extraContent ]
                ]
            ]


newContainer : Mass -> Container Item
newContainer mass =
    Container.new mass getMass equals


newFoldableItem : ( key, ID -> Item ) -> ID -> ( key, Item )
newFoldableItem ( key, itemFactory ) id =
    ( key, itemFactory id )


new : ItemType -> ID -> Item
new itemType id =
    newWithOptions itemType id Normal Identified


newWithOptions : ItemType -> ID -> ItemStatus -> IdentificationStatus -> Item
newWithOptions itemType id status idStatus =
    case itemType of
        Weapon weaponType ->
            ItemWeapon (newWeapon weaponType id status idStatus)

        Armour armourType ->
            ItemArmour (newArmour armourType id status idStatus)

        Shield shieldType ->
            ItemShield (newShield shieldType id status idStatus)

        Helmet helmetType ->
            ItemHelmet (newHelmet helmetType id status idStatus)

        Bracers bracersType ->
            ItemBracers (newBracers bracersType id status idStatus)

        Gauntlets gauntletsType ->
            ItemGauntlets (newGauntlets gauntletsType id status idStatus)

        Belt beltType ->
            ItemBelt (newBelt beltType id status idStatus newContainer)

        Pack packType ->
            ItemPack (newPack packType id status idStatus newContainer)

        Purse ->
            ItemPurse (newPurse id status idStatus)

        -- Neckwear
        --        Overgarment
        --        Ring
        --        Boots
        _ ->
            ItemWeapon (newWeapon Dagger id status idStatus)
