module View exposing
    ( View
    , map
    , none
    , placeholder
    , toBrowserDocument
    )

import Browser
import Html.Styled as Html exposing (Html)


type alias View msg =
    { title : String
    , body : List (Html msg)
    }


placeholder : String -> View msg
placeholder str =
    { title = str
    , body = [ Html.text str ]
    }


none : View msg
none =
    placeholder ""


map : (a -> b) -> View a -> View b
map fn view =
    { title = view.title
    , body =
        view.body
            |> List.map (Html.map fn)
    }


toBrowserDocument : View msg -> Browser.Document msg
toBrowserDocument view =
    { title = view.title
    , body =
        view.body
            |> List.map Html.toUnstyled
    }
