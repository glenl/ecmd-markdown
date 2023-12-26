# Markdown with Elm-css

This is a test application using an
[elm-markdown](https://package.elm-lang.org/packages/dillonkearns/elm-markdown/latest/)
renderer developed with
[elm-css](https://package.elm-lang.org/packages/rtfeldman/elm-css/latest/).
It is a single page application built with
[elm-spa](https://elm-spa.dev).


I was intent on keeping the focus on the markdown renderer for another
project so I'm pretty sure that I didn't write as much
[elm](https://elm-lang.org/) as these package authors:

 - [Dillonkearns](https://github.com/dillonkearns)
   for [elm-markdown](https://package.elm-lang.org/packages/dillonkearns/elm-markdown/latest/)
 - [rtfeldman](https://github.com/dillonkearns)
   for [elm-css](https://package.elm-lang.org/packages/rtfeldman/elm-css/latest/)
 - [ryannhg](https://github.com/ryannhg/elm-spa) for
   elm-spa](https://elm-spa.dev)

## dependencies

 - Requires the latest LTS version of [Node.js](https://nodejs.org/)

 - Uses

```bash
npm install -g elm elm-spa
```

## running locally

```bash
elm-spa gen
elm-spa server  # starts this app at http:/localhost:1234
```
