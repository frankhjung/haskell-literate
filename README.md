# Literate Haskell Examples

A collection of Literate Haskell programs that can be compiled and rendered to
HTML or PDF documents.

## Quick Start

```bash
code literate.code-workspace
make html pdf
xdg-open public/bird.html
```

## Prerequisites

To build programs and documents you need:

- [GNU Make](https://www.gnu.org/software/make/)
- [GHC (Glasgow Haskell Compiler)](https://www.haskell.org/ghc/)
- [Pandoc](https://pandoc.org/)
- [Haskell Language Server](https://haskell-language-server.readthedocs.io/)
  (recommended for VS Code workspace features)

## Workspace

Open the project with the provided VS Code workspace:

```bash
code literate.code-workspace
```

The workspace enables Haskell Language Server (`hls`) and configures formatting
and linting for Haskell files.

## Project Layout

- `doc/` contains source `.lhs` files.
- `public/` contains generated HTML/PDF artefacts.

## Build Executables

To build executables from all files in `doc/*.lhs`, run:

```bash
make all
```

This creates binaries in `public/` (for example `public/bird` and
`public/helloworld`).

## Render Documents

Build all HTML and PDF outputs:

```bash
make html pdf
```

Generated artefacts are written to `public/`:

- `public/bird.html`
- `public/bird.pdf`
- `public/helloworld.html`
- `public/helloworld.pdf`

Build a single target:

```bash
make public/bird.html
make public/bird.pdf
make public/helloworld.pdf
```

Manual `pandoc` example for `doc/bird.lhs` (matching current Makefile flags):

```bash
pandoc -f markdown+lhs -s -t html --css haskell.css doc/bird.lhs -o public/bird.html
```

## Clean

```bash
make clean
make cleanall
```

`clean` removes intermediate build files. `cleanall` removes all generated
artefacts, including `public/`.
