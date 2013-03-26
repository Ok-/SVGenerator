EXEC = svgenerator

CAMLC = ocamlc
CAMLDEP = ocamldep
CAMLLEX = ocamllex
CAMLYACC = ocamlyacc

all:
	$(CAMLLEX) tp_lexer.mll
	$(CAMLYACC) tp_parser.mly
	$(CAMLC) -c fonctions.ml
	$(CAMLC) -c svg_builder.ml
	$(CAMLC) -c tp_parser.mli
	$(CAMLC) -c tp_parser.ml
	$(CAMLC) -c tp_lexer.ml
	#$(CAMLC) interpret_func.cmo interpret_lexer.cmo interpret_parser.cmo interpret.ml -o $(EXEC)
	$(CAMLC) fonctions.cmo svg_builder.cmo tp_parser.cmo tp_lexer.cmo main.ml -o $(EXEC)

clean:
	rm -f *.cm[iox] *.mli *~ .*~
	rm -rf tp_lexer.ml tp_parser.ml
	rm -f $(EXEC)
	rm -f $(EXEC).opt
