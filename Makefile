#!/usr/bin/env make

.SUFFIXES:
.SUFFIXES: .o .hs .lhs .html .pdf

%	: %.lhs
	-ghc -package stm -package mtl --make $<

%.html	: %.lhs
	-pandoc -r markdown+lhs -s $< -w html --css haskell.css -o $@

%.pdf	: %.lhs
	-pandoc -r markdown+lhs -s $< --css haskell.css -o $@

LHS	:= $(wildcard doc/*.lhs)

.PHONY: all
all:	$(basename $(LHS))

.PHONY: html
html:	$(patsubst %.lhs, %.html, $(LHS))

.PHONY: pdf
html:	$(patsubst %.lhs, %.pdf, $(LHS))

.PHONY: clean
clean:
	-$(RM) $(addsuffix .hi, $(basename $(LHS)))
	-$(RM) $(addsuffix .o, $(basename $(LHS)))
	-$(RM) $(addsuffix .prof, $(basename $(LHS)))

.PHONY: cleanall
cleanall: clean
	-$(RM) $(patsubst %.lhs, %, $(LHS))
	-$(RM) $(patsubst %.lhs, %.html, $(LHS))
	-$(RM) $(patsubst %.lhs, %.pdf, $(LHS))
