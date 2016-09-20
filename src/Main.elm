module Main exposing (..)

import Html.App
import Html exposing (..)
import Html.Attributes exposing (type', value, id, for)
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
    let
        city =
            Maybe.withDefault "" model.city

        state =
            Maybe.withDefault "" model.state

        zip =
            Maybe.withDefault "" model.zip
    in
        form []
            [ label [ for "city" ] [ text "City" ]
            , input [ onInput NewCity, id "city", type' "text" ] []
            , label [ for "state" ] [ text "State" ]
            , input [ onInput NewState, id "state", type' "text" ] []
            , label [ for "zip" ] [ text "ZIP" ]
            , input [ onInput NewZip, id "zip", type' "text" ] []
            ]
