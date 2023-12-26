module UI.Layout exposing
    ( link
    , pageBg
    , viewDoc
    )

import Css
import Gen.Route as Route exposing (Route)
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attr
import Url exposing (Url)


pageBg : Css.Color
pageBg =
    Css.hex "efefef"


link : Css.Style
link =
    Css.batch
        [ Css.textDecoration Css.none
        , Css.color <| Css.hex "3f4b5c"
        , Css.hover
            [ Css.color <| Css.hex "5f80b8"
            , Css.textDecoration Css.underline
            ]
        ]



-- MAIN TITLE STRIP


navbar : Html msg
navbar =
    Html.nav []
        [ Html.header
            [ Attr.css
                [ Css.displayFlex
                , Css.flexDirection Css.row
                , Css.alignItems Css.center
                , Css.padding <| Css.px 24
                , Css.margin Css.zero
                , Css.backgroundColor <| Css.hex "03a7dd"
                , Css.color <| Css.hex "fff"
                ]
            ]
            [ Html.div
                [ Attr.css
                    [ Css.fontFamilies [ "Days One", "sans-serif" ]
                    , Css.fontSize <| Css.px 24
                    ]
                ]
                [ Html.text "Elm-Css Markdown Test" ]
            ]
        ]



-- SIDEBAR


type alias Target =
    { name : String
    , route : Route
    }


targets : List Target
targets =
    [ { name = "Home", route = Route.Home_ }
    , { name = "Headers", route = Route.Headers }
    , { name = "Emphasis", route = Route.Emphasis }
    , { name = "Lists", route = Route.Lists }
    , { name = "Blocks", route = Route.Blocks }
    , { name = "Tables", route = Route.Tables }
    , { name = "Images", route = Route.Images }
    ]


sideLinkStyle : Bool -> Css.Style
sideLinkStyle hit =
    let
        styles =
            if hit then
                [ Css.fontWeight Css.bold ]

            else
                []
    in
    Css.batch
        (List.append
            [ Css.textDecoration Css.none
            , Css.color <| Css.hex "1f2b40"
            , Css.hover
                [ Css.fontWeight Css.bolder
                ]
            ]
            styles
        )


sectItem : Route -> Target -> Html msg
sectItem route target =
    Html.p
        [ Attr.css
            [ Css.lineHeight <| Css.px 8
            , Css.listStyleType Css.none
            ]
        ]
        [ Html.a
            [ Attr.href (Route.toHref target.route)
            , Attr.css
                [ sideLinkStyle <| route == target.route
                ]
            ]
            [ Html.text target.name ]
        ]


sideBar : Url -> Html msg
sideBar url =
    let
        route : Route
        route =
            Route.fromUrl url
    in
    Html.nav
        [ Attr.css
            [ Css.displayFlex
            , Css.flexDirection Css.column
            , Css.margin4 (Css.px 28) (Css.px 0) (Css.px 0) (Css.px 40)
            ]
        ]
        (List.map (sectItem route) targets)



--VIEW


viewDoc : Url -> List (Html msg) -> List (Html msg)
viewDoc url view =
    [ Html.div
        [ Attr.css
            [ Css.fontFamilies [ "Noto Sans", "sans-serif" ]
            , Css.backgroundColor pageBg
            ]
        ]
        [ navbar
        , Html.div
            [ Attr.css
                [ Css.displayFlex
                , Css.flexDirection Css.row
                , Css.backgroundColor pageBg
                ]
            ]
            [ sideBar url
            , Html.div
                [ Attr.css
                    [ Css.flexDirection Css.column
                    , Css.fontSize <| Css.px 18
                    , Css.width <| Css.em 32
                    , Css.paddingLeft <| Css.px 20
                    , Css.marginLeft <| Css.px 50
                    , Css.borderLeft3 (Css.px 1) Css.solid (Css.hex "e0e0e0")
                    ]
                ]
                view
            ]
        , footer
        ]
    ]



-- FOOTER


footer : Html msg
footer =
    Html.footer
        [ Attr.css
            [ Css.padding <| Css.rem 1
            , Css.displayFlex
            , Css.flexDirection Css.row
            , Css.justifyContent Css.center
            , Css.alignItems Css.center
            , Css.color <| Css.hex "808080"
            , Css.backgroundColor pageBg
            , Css.borderTop3 (Css.px 1) Css.solid (Css.hex "e0e0e0")
            ]
        ]
        [ Html.text "© 2023"
        , Html.a
            [ Attr.href "/"
            , Attr.css
                [ link
                , Css.marginLeft <| Css.px 6
                ]
            ]
            [ Html.text "A Real Copyright link would go here" ]
        ]
