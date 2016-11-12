module Stats
    exposing
        ( Stats
        , Msg(..)
        , new
        , takeHit
        , combatStats
        , isDead
        , printHP
        , printSP
        )


type Stats
    = A Model


type Msg
    = Alive
    | Dead


type alias Model =
    { maxHP : Int
    , currentHP : Int
    , maxSP : Int
    , currentSP : Int
    , damageRange : ( Int, Int )
    , ac : Int
    , hitChance : Int
    }

{-|
-}



new : Int -> Int -> Stats
new hp sp =
    A (Model hp hp sp sp ( 1, 6 ) 0 50)


isDead : Stats -> Bool
isDead (A model) =
    model.currentHP < 0


takeHit : Int -> Stats -> ( Stats, Msg )
takeHit damage (A model) =
    let
        hp' =
            model.currentHP - damage

        msg =
            if hp' > 0 then
                Alive
            else
                Dead
    in
        ( A { model | currentHP = hp' }, msg )


combatStats : Stats -> ( ( Int, Int ), Int, Int )
combatStats (A model) =
    ( model.damageRange, model.ac, model.hitChance )


printHP : Stats -> String
printHP (A model) =
    printAOverB model.currentHP model.maxHP


printSP : Stats -> String
printSP (A model) =
    printAOverB model.currentSP model.maxSP


printAOverB : a -> b -> String
printAOverB a b =
    toString a ++ " / " ++ toString b
