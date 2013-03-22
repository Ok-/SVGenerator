EXEC = svgenerator

CAMLC = ocamlc
CAMLDEP = ocamldep
CAMLLEX = ocamllex
CAMLYACC = ocamlyacc

all:
	$(CAMLLEX) tp_lexer.mll
	$(CAMLYACC) tp_parser.mly
	$(CAMLC) -c fonctions.ml
	#$(CAMLC) -c tp_parser.mli
	$(CAMLC) -c tp_parser.ml
	$(CAMLC) -c tp_lexer.ml
	#$(CAMLC) -c interpret_lexer.ml
	#$(CAMLC) interpret_func.cmo interpret_lexer.cmo interpret_parser.cmo interpret.ml -o $(EXEC)
	$(CAMLC) svgenerator.cmo svgenerator.ml main.ml -o $(EXEC)

clean:
	rm -f *.cm[iox] *.mli *~ .*~
	rm -rf tp_lexer.ml tp_parser.ml

