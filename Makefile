# Build for Literate Haskell projects.

.PHONY: all html pdf clean cleanall help
.DELETE_ON_ERROR:
.SUFFIXES:

LHS := $(wildcard doc/*.lhs)
PUBLIC_DIR := public
NAMES := $(basename $(notdir $(LHS)))
EXECUTABLES := $(addprefix $(PUBLIC_DIR)/,$(NAMES))
HTMLS := $(addprefix $(PUBLIC_DIR)/,$(addsuffix .html,$(NAMES)))
PDFS := $(addprefix $(PUBLIC_DIR)/,$(addsuffix .pdf,$(NAMES)))

GHC_PKGS ?=
GHCFLAGS := --make $(foreach pkg,$(GHC_PKGS),-package $(pkg))
PANDOC_FLAGS := -f markdown+lhs -s
PANDOC_HTML_FLAGS := -t html --css haskell.css

.DEFAULT_GOAL := html

all: $(EXECUTABLES)

html: $(HTMLS)

pdf: $(PDFS)


$(EXECUTABLES): $(PUBLIC_DIR)/%: doc/%.lhs | $(PUBLIC_DIR)
	ghc $(GHCFLAGS) $< -o $@

$(PUBLIC_DIR)/%.html: doc/%.lhs haskell.css | $(PUBLIC_DIR)
	pandoc $(PANDOC_FLAGS) $(PANDOC_HTML_FLAGS) $< -o $@

$(PUBLIC_DIR)/%.pdf: doc/%.lhs | $(PUBLIC_DIR)
	pandoc $(PANDOC_FLAGS) $< -o $@

$(PUBLIC_DIR):
	mkdir -p $@

clean:
	@echo "Cleaning intermediate files..."
	-$(RM) $(LHS:.lhs=.hi) $(LHS:.lhs=.o) $(LHS:.lhs=.prof)
	-$(RM) *.aux *.fls *.log
	-$(RM) $(PUBLIC_DIR)/*.aux $(PUBLIC_DIR)/*.fls $(PUBLIC_DIR)/*.log

cleanall: clean
	@echo "Cleaning all generated files..."
	-$(RM) $(EXECUTABLES) $(HTMLS) $(PDFS)
	-$(RM) -r $(PUBLIC_DIR)

help:
	@echo "Literate Haskell Build Targets:"
	@echo "  all       - Compile all .lhs files to executables"
	@echo "  html      - Render all .lhs files to HTML"
	@echo "  pdf       - Render all .lhs files to PDF"
	@echo "  clean     - Remove intermediate build files"
	@echo "  cleanall  - Remove all generated files"
	@echo "  help      - Show this help message"
