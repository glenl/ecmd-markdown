module UI.Docs exposing (Model, Msg, page)

import ECMD.Markdown exposing (renderer)
import Html.Styled as Html exposing (Html)
import Http
import Markdown.Parser
import Markdown.Renderer
import Page
import RemoteData exposing (WebData)
import Request
import Shared
import UI.Layout
import Url exposing (Url)
import View exposing (View)


page : Shared.Model -> Request.With params -> Page.With Model Msg
page _ req =
    Page.element
        { init = init req.url
        , update = update
        , view = view req.url
        , subscriptions = \_ -> Sub.none
        }



-- INIT


type alias Model =
    { markdown : WebData String
    }


init : Url -> ( Model, Cmd Msg )
init url =
    let
        path : String
        path =
            case url.path of
                "/" ->
                    "/home"

                _ ->
                    url.path
    in
    ( { markdown = RemoteData.Loading
      }
    , Http.get
        { url = "/content" ++ path ++ ".md"
        , expect = Http.expectString GotMarkdown
        }
    )


type Msg
    = GotMarkdown (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        GotMarkdown response ->
            case response of
                Ok md ->
                    ( { model
                        | markdown = RemoteData.Success md
                      }
                    , Cmd.none
                    )

                Err e ->
                    ( { model
                        | markdown = RemoteData.Failure e
                      }
                    , Cmd.none
                    )


parse : String -> Html msg
parse md =
    Markdown.Parser.parse md
        |> Result.mapError (\_ -> "Failed to parse markdown.")
        |> Result.andThen (Markdown.Renderer.render renderer)
        |> Result.withDefault []
        |> Html.div []


view : Url -> Model -> View msg
view url model =
    { title = "ECMD Markdown Reference"
    , body =
        UI.Layout.viewDoc
            url
            [ case model.markdown of
                RemoteData.Loading ->
                    parse "# Loading.\n"

                RemoteData.NotAsked ->
                    parse "# Not asked.\n"

                RemoteData.Failure _ ->
                    parse "# Oops!\n\n"

                RemoteData.Success markdown ->
                    parse markdown
            ]
    }
