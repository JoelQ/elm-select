module Main exposing (..)

import Html.App
import Html exposing (..)


main : Program Never
main =
    Html.App.beginnerProgram
        { model = []
        , update = (\_ _ -> [])
        , view = (\_ -> h1 [] [ text "Select" ])
        }
