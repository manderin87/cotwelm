module Mass exposing (Mass, new, lessThanOrEqualTo, Msg(..), add)


type alias Model =
    { bulk : Int
    , weight : Int
    }


type Mass
    = Mass Model


type Msg
    = Ok
    | TooHeavy
    | TooBulky


new : Int -> Int -> Mass
new bulk weight =
    Mass <| Model bulk weight


add : Mass -> Mass -> Mass
add (Mass a) (Mass b) =
    Mass
        { bulk = a.bulk + b.bulk
        , weight = a.weight + b.weight
        }


lessThanOrEqualTo : Mass -> Mass -> Msg
lessThanOrEqualTo (Mass a) (Mass b) =
    let
        bulkWeight =
            ( a.bulk > b.bulk, a.weight > b.weight )
    in
        case bulkWeight of
            ( True, _ ) ->
                TooBulky

            ( _, True ) ->
                TooHeavy

            _ ->
                Ok