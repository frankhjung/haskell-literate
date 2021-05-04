# Literate Haskell Examples

A collection literate Haskell programs that can be rendered into HTML or PDF
documents.

## Build

To build the executable, run:

```bash
make all
```

## Literate Haskell

To render [bird.lhs](doc/bird.lhs) into a PDF, use:

```bash
pandoc -r markdown+lhs -s bird.lhs --css haskell.css -o bird.pdf
```

Or

```bash
make doc/bird.pdf
```

To render to HTML use:

```bash
make doc/bird.html
```

## Pre-requisites

To build these program and documents you will need:

* [GNU Make](https://www.gnu.org/software/make/)
* [Haskell GHC compiler](https://www.haskell.org/ghc/)
* [Pandoc](https://pandoc.org/)
