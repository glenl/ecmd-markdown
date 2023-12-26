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

 - [dillonkearns](https://github.com/dillonkearns)
   for [elm-markdown](https://package.elm-lang.org/packages/dillonkearns/elm-markdown/latest/)
 - [rtfeldman](https://github.com/rtfeldman)
   for [elm-css](https://package.elm-lang.org/packages/rtfeldman/elm-css/latest/)
 - [ryannhg](https://github.com/ryannhg) for
   [elm-spa](https://elm-spa.dev)

## Overview

The markdown was developed for use in another project that is using
dillonkearns'
[elm-graphql](https://github.com/dillonkearns/elm-graphql)
package. With the graphql server in development it made sense to
develop the markdown renderer separately until the API stabilized.

## Dependencies

 - Requires the latest LTS version of [Node.js](https://nodejs.org/)

 - Uses

```bash
npm install -g elm elm-spa
```

## Running locally

```bash
elm-spa gen
elm-spa server  # starts this app at http:/localhost:1234
```
