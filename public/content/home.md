# Markdown in Elm-css

After deciding to use [elm-spa](https://www.elm-spa.dev/) in my
project, I was reading through those documents and admiring the text
presentation using
[elm-markdown](https://package.elm-lang.org/packages/dillonkearns/elm-markdown/latest/).
This approach fit our project for which we had already decided to
style using
[elm-css](https://package.elm-lang.org/packages/rtfeldman/elm-css/latest/)
and that started me down the path of this small project because I
needed to create a markdown renderer for elm-css and I wanted to test
the results beyond the subset of markdown I would use for my
site. This site represents a test of this approach.

This single-page application isn't meant to do anything more than test
a markdown renderer styled with `elm-css`. Each link in the sidebar
will navigate to a page written mostly with the markdown that page
represents.

----

There are some obvious styles, like the simple paragraphs on this
page, that don't have their own page.
