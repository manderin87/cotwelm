module SplashView exposing (view, Msg(..))


import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)


type Msg
    = NewGame
    | LoadGame
    | Overview


{-| Shows the splash screen
  @doc view
-}
view : Html Msg
view =
    let
        bgStyle =
            [ ( "backgroundColor", "black" ) ]
    in
        div
            [ class "ui center aligned middle aligned grid"
            , style bgStyle
            ]
            [ div [ class "ui one column" ]
                [ div [ class "ui column" ]
                    [ img [ src "/assets/landing_cotw1.jpg" ] []
                    ]
                , div [ class "ui column" ]
                    [ img [ src "/assets/landing_cotw2.jpg" ] []
                    ]
                , div [ class "ui column" ]
                    [ div [ class "ui buttons" ]
                        [ button [ class "ui button primary", onClick NewGame ] [ text "New Game" ]
                        , button [ class "ui button", onClick LoadGame ] [ text "Load Game" ]
                        , button [ class "ui button", onClick Overview ] [ text "Overview" ]
                        ]
                    ]
                ]
            ]
