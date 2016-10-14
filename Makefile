include Makefile.conf

################################################################################
CC				= ocamlc
OCAMLDOC		= ocamldoc
PACKAGES		= -package gen_js_api
DOC_OUTPUT_DIR	= doc

ML_FILE			= $(patsubst %.mli, %.ml, $(MLI_FILE))
CMI_FILE		= $(patsubst %.mli, %.cmi, $(MLI_FILE))
CMO_FILE		= $(patsubst %.mli, %.cmo, $(MLI_FILE))
CMA_FILE		= $(patsubst %.mli, %.cma, $(MLI_FILE))
################################################################################

################################################################################
build:
	ocamlfind gen_js_api/gen_js_api $(MLI_FILE)
	ocamlfind $(CC) -c $(PACKAGES) $(MLI_FILE)
	ocamlfind $(CC) -c $(PACKAGES) $(ML_FILE)
	ocamlfind $(CC) -a -o $(CMA_FILE) $(CMO_FILE)

install: build
	ocamlfind install $(LIB_NAME) META $(CMA_FILE) $(CMI_FILE)

remove:
	ocamlfind remove $(LIB_NAME)

doc-html:
	mkdir -p $(DOC_OUTPUT_DIR)
	ocamlfind $(OCAMLDOC) -html $(PACKAGES) -d $(DOC_OUTPUT_DIR) $(MLI_FILE)

clean:
	$(RM) $(CMI_FILE) $(CMO_FILE) $(ML_FILE) $(CMA_FILE)

clean-doc:
	$(RM) -r $(DOC_OUTPUT_DIR)

re: clean all
################################################################################
