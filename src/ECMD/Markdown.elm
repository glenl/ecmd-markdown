module ECMD.Markdown exposing (renderer)

import Css
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attr
import Http exposing (task)
import Markdown.Block as Block exposing (ListItem(..), Task(..))
import Markdown.Html
import Markdown.Renderer


renderer : Markdown.Renderer.Renderer (Html msg)
renderer =
    { heading = heading
    , paragraph = paragraph
    , blockQuote = blockquote
    , html = Markdown.Html.oneOf []
    , text = text
    , codeSpan = codespan
    , strong = strong
    , emphasis = emphasis
    , strikethrough = strikethrough
    , hardLineBreak = hardlinebreak
    , link = link
    , image = image
    , unorderedList = unorderedlist
    , orderedList = orderedlist
    , codeBlock = codeblock
    , thematicBreak = thematicbreak
    , table = table
    , tableHeader = tableheader
    , tableBody = tablebody
    , tableRow = tablerow
    , tableCell = tablecell
    , tableHeaderCell = tableheadercell
    }



-- COLORS


blockBg : Css.Color
blockBg =
    Css.hex "e6e6e6"


divisionColor : Css.Color
divisionColor =
    Css.hex "c0c0c0"


type alias TableColorSet =
    { background : Css.Color
    , headerBg : Css.Color
    , headerColor : Css.Color
    , bodyBg : Css.Color
    , bodyColor : Css.Color
    }


defaultTable : TableColorSet
defaultTable =
    { background = Css.hex "777"
    , headerBg = Css.hex "aec3e8"
    , headerColor = Css.hex "000"
    , bodyBg = Css.hex "dae8f0"
    , bodyColor = Css.hex "2d2d2d"
    }



-- SHAREABLE STYLES


code : Css.Style
code =
    Css.batch
        [ Css.fontFamilies [ "Fira Code", "monospace" ]
        , Css.fontSize Css.smaller
        ]



-- MARKDOWN


heading :
    { level : Block.HeadingLevel
    , rawText : String
    , children : List (Html msg)
    }
    -> Html msg
heading options =
    case options.level of
        Block.H1 ->
            Html.h1 [ Attr.css [ Css.lineHeight <| Css.num 1.0 ] ]
                options.children

        Block.H2 ->
            Html.h2 [ Attr.css [ Css.lineHeight <| Css.num 1.2 ] ]
                options.children

        Block.H3 ->
            Html.h3 [ Attr.css [ Css.lineHeight <| Css.num 1.2 ] ]
                options.children

        Block.H4 ->
            Html.h4 [ Attr.css [ Css.lineHeight <| Css.num 1.2 ] ]
                options.children

        Block.H5 ->
            Html.h5 [ Attr.css [ Css.lineHeight <| Css.num 1.2 ] ]
                options.children

        Block.H6 ->
            Html.h6 [ Attr.css [ Css.lineHeight <| Css.num 1.2 ] ]
                options.children


paragraph : List (Html msg) -> Html msg
paragraph content =
    Html.p []
        content


blockquote : List (Html msg) -> Html msg
blockquote body =
    let
        blockWidth = Css.px 8
    in
    Html.div
        [ Attr.css
            [ Css.flexDirection Css.column
            , Css.borderLeft3
                blockWidth
                Css.solid
                divisionColor
            , Css.paddingLeft blockWidth
            ]
        ]
        body


text : String -> Html msg
text content =
    Html.text content


codespan : String -> Html msg
codespan content =
    Html.span
        [ Attr.css
            [ code
            , Css.backgroundColor blockBg
            ]
        ]
        [ Html.text content ]


strong : List (Html msg) -> Html msg
strong content =
    Html.strong []
        content


emphasis : List (Html msg) -> Html msg
emphasis content =
    Html.em []
        content


strikethrough : List (Html msg) -> Html msg
strikethrough content =
    Html.span
        [ Attr.css
            [ Css.textDecoration Css.lineThrough
            ]
        ]
        content


hardlinebreak : Html msg
hardlinebreak =
    Html.br [] []


link :
    { title : Maybe String
    , destination : String
    }
    -> List (Html msg)
    -> Html msg
link options body =
    Html.a
        [ Attr.href options.destination
        ]
        body


image :
    { alt : String
    , src : String
    , title : Maybe String
    }
    -> Html msg
image content =
    let
        label =
            case content.title of
                Just s ->
                    [ Html.text s ]

                Nothing ->
                    []
    in
    Html.img
        [ Attr.src content.src
        , Attr.alt content.alt
        ]
        label


unorderedlist : List (ListItem (Html msg)) -> Html msg
unorderedlist items =
    Html.ul
        [ Attr.css
            [ Css.marginLeft <| Css.rem 1.4
            ]
        ]
        (items
            |> List.map
                (\(ListItem task children) ->
                    case task of
                        IncompleteTask ->
                            checkbox False children

                        CompletedTask ->
                            checkbox True children

                        NoTask ->
                            Html.li [] children
                )
        )


orderedlist : Int -> List (List (Html msg)) -> Html msg
orderedlist nStart children =
    Html.ol
        [ Attr.css
            [ Css.marginLeft <| Css.rem 1.0
            ]
        , Attr.start nStart
        ]
        (List.map (\child -> Html.li [] child) children)


checkbox : Bool -> List (Html msg) -> Html msg
checkbox ticked detail =
    Html.div
        [ Attr.css
            [ Css.cursor Css.pointer ]
        ]
        (Html.input
            [ Attr.type_ "checkbox"
            , Attr.checked ticked
            , Attr.css [ Css.marginRight <| Css.px 12 ]
            ]
            []
            :: detail
        )


codeblock :
    { body : String
    , language : Maybe String
    }
    -> Html msg
codeblock content =
    Html.pre
        [ Attr.css
            [ Css.border3 (Css.px 1) Css.solid divisionColor
            , Css.borderRadius <| Css.rem 0.4
            , Css.backgroundColor blockBg
            , Css.padding <| Css.rem 1
            , Css.overflow <| Css.auto
            , Css.display <| Css.block
            ]
        ]
        [ Html.code [ Attr.css [ code ] ]
            [ Html.text content.body ]
        ]


thematicbreak : Html msg
thematicbreak =
    Html.hr [] []


table : List (Html msg) -> Html msg
table content =
    Html.table
        [ Attr.css
            [ Css.backgroundColor defaultTable.background
            , Css.borderSpacing <| Css.px 1
            ]
        ]
        content


tableheader : List (Html msg) -> Html msg
tableheader content =
    Html.thead
        [ Attr.css
            [ Css.backgroundColor defaultTable.headerBg
            , Css.color defaultTable.headerColor
            , Css.fontWeight Css.bold
            ]
        ]
        content


tablebody : List (Html msg) -> Html msg
tablebody content =
    Html.tbody
        [ Attr.css
            [ Css.backgroundColor defaultTable.bodyBg
            , Css.color defaultTable.bodyColor
            ]
        ]
        content


alignment : Maybe Block.Alignment -> List (Html.Attribute msg)
alignment maybealign =
    maybealign
        |> Maybe.map
            (\align ->
                case align of
                    Block.AlignLeft ->
                        "left"

                    Block.AlignCenter ->
                        "center"

                    Block.AlignRight ->
                        "right"
            )
        |> Maybe.map Attr.align
        |> Maybe.map List.singleton
        |> Maybe.withDefault []


tablecell : Maybe Block.Alignment -> List (Html msg) -> Html msg
tablecell align content =
    Html.td
        (List.append (alignment align)
            [ Attr.css
                [ Css.padding <| Css.px 6 ]
            ]
        )
        content


tablerow : List (Html msg) -> Html msg
tablerow content =
    Html.tr
        []
        content


tableheadercell : Maybe Block.Alignment -> List (Html msg) -> Html msg
tableheadercell align content =
    Html.th
        (List.append (alignment align)
            [ Attr.css
                [ Css.padding <| Css.px 6 ]
            ]
        )
        content
