EXEC = svgenerator

CAMLC = ocamlc
CAMLDEP = ocamldep
CAMLLEX = ocamllex
CAMLYACC = ocamlyacc

all:
	$(CAMLLEX) lexer.mll
	$(CAMLYACC) parser.mly
	$(CAMLC) -c lexer.ml
	$(CAMLC) -c interpret_parser.mli
	$(CAMLC) -c interpret_parser.ml
	$(CAMLC) -c interpret_lexer.ml
	#$(CAMLC) interpret_func.cmo interpret_lexer.cmo interpret_parser.cmo interpret.ml -o $(EXEC)
	$(CAMLC) svgenerator.cmo svgenerator.ml -o $(EXEC)

clean:
	rm -f *.cm[iox] *.mli *~ .*~
	rm -rf interpret_lexer.ml interpret_parser.ml

