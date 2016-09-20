module Main exposing (..)

import Html.App
import Html exposing (..)
import Html.Attributes exposing (type', value, id, for, selected)
import Html.Events exposing (onInput)


type alias Model =
    { city : Maybe String
    , state : Maybe String
    , zip : Maybe String
    }


emptyAddress : Model
emptyAddress =
    Model Nothing Nothing Nothing


main : Program Never
main =
    Html.App.beginnerProgram
        { model = emptyAddress
        , update = update
        , view = view
        }


type Msg
    = NewState String
    | NewCity String
    | NewZip String


update : Msg -> Model -> Model
update msg model =
    case msg of
        NewCity city ->
            { model | city = Just city }

        NewState state ->
            { model | state = Just state }

        NewZip zip ->
            { model | zip = Just zip }


view : Model -> Html Msg
view model =
    main' []
        [ h1 [] [ text "Address" ]
        , formattedAddress model
        , addressForm model
        ]


formattedAddress : Model -> Html a
formattedAddress model =
    let
        city =
            Maybe.withDefault "__" model.city

        state =
            Maybe.withDefault "__" model.state

        zip =
            Maybe.withDefault "__" model.zip
    in
        section [] [ text <| city ++ ", " ++ state ++ " " ++ zip ]


addressForm : Model -> Html Msg
addressForm model =
    form []
        [ textField "city" NewCity model.city
        , stateDropdown model.state
        , textField "zip" NewZip model.zip
        ]


textField : String -> (String -> Msg) -> Maybe String -> Html Msg
textField name msg val =
    let
        v =
            Maybe.withDefault "" val
    in
        div []
            [ label [ for name ] [ text name ]
            , input [ onInput msg, id name, type' "text", value v ] []
            ]


stateDropdown : Maybe String -> Html Msg
stateDropdown selectedValue =
    div []
        [ label [ for "state" ] [ text "state" ]
        , select [ id "state", onInput NewState ] (stateOptions selectedValue)
        ]


stateOptions : Maybe String -> List (Html a)
stateOptions selectedValue =
    emptyOption :: (List.map (stateOption selectedValue) states)


emptyOption : Html a
emptyOption =
    option [] [ text "Select an option" ]


stateOption : Maybe String -> ( String, String ) -> Html a
stateOption selectedValue ( name, abbreviation ) =
    case selectedValue of
        Just selectedV ->
            if selectedV == abbreviation then
                option [ value abbreviation, selected True ] [ text name ]
            else
                option [ value abbreviation ] [ text name ]

        Nothing ->
            option [ value abbreviation ] [ text name ]


states : List ( String, String )
states =
    [ ( "ALABAMA", "AL" )
    , ( "ALASKA", "AK" )
    , ( "ARIZONA", "AZ" )
    , ( "ARKANSAS", "AR" )
    , ( "CALIFORNIA", "CA" )
    , ( "COLORADO", "CO" )
    , ( "CONNECTICUT", "CT" )
    , ( "DELAWARE", "DE" )
    , ( "FLORIDA", "FL" )
    , ( "GEORGIA", "GA" )
    , ( "HAWAII", "HI" )
    , ( "IDAHO", "ID" )
    , ( "ILLINOIS", "IL" )
    , ( "INDIANA", "IN" )
    , ( "IOWA", "IA" )
    , ( "KANSAS", "KS" )
    , ( "KENTUCKY", "KY" )
    , ( "LOUISIANA", "LA" )
    , ( "MAINE", "ME" )
    , ( "MARYLAND", "MD" )
    , ( "MASSACHUSETTS", "MA" )
    , ( "MICHIGAN", "MI" )
    , ( "MINNESOTA", "MN" )
    , ( "MISSISSIPPI", "MS" )
    , ( "MISSOURI", "MO" )
    , ( "MONTANA", "MT" )
    , ( "NEBRASKA", "NE" )
    , ( "NEVADA", "NV" )
    , ( "NEW HAMPSHIRE", "NH" )
    , ( "NEW JERSEY", "NJ" )
    , ( "NEW MEXICO", "NM" )
    , ( "NEW YORK", "NY" )
    , ( "NORTH CAROLINA", "NC" )
    , ( "NORTH DAKOTA", "ND" )
    , ( "OHIO", "OH" )
    , ( "OKLAHOMA", "OK" )
    , ( "OREGON", "OR" )
    , ( "PENNSYLVANIA", "PA" )
    , ( "RHODE ISLAND", "RI" )
    , ( "SOUTH CAROLINANC", "SC" )
    , ( "SOUTH DAKOTAND", "SD" )
    , ( "TENNESSEE", "TN" )
    , ( "TEXAS", "TX" )
    , ( "UTAH", "UT" )
    , ( "VERMONT", "VT" )
    , ( "VIRGINIA", "VA" )
    , ( "WASHINGTON", "WA" )
    , ( "WEST VIRGINIAVA", "WV" )
    , ( "WISCONSIN", "WI" )
    , ( "WYOMING", "WY" )
    ]
