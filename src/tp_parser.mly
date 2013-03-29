%{
open Fonctions;;
open String;;
open List;;
open Svg_builder;;

let document = start_xml();;
%}

%token EOF

%token <string> WORD
%token <string> INTEGER

%token IMAGE
%token BEGIN_BLOCK
%token END_BLOCK

%token DOT
%token RECTANGLE
%token CIRCLE
%token LINE
%token TEXT
%token RADIUS

%token SEMICOLON
%token COMA
%token LEFT_PARENTHESIS
%token RIGHT_PARENTHESIS

%start main
%type <unit> main


%%

main:
	def_image EOF {print_endline "Start"; $1}
;

def_image:
    IMAGE image_name def_image_size BEGIN_BLOCK content END_BLOCK {
    	let (w,h) = $3 in
    	let empty_document = begin_root(document, w, h) in
    	let titled_document = add_title empty_document $2 in 
    	let document_with_content = append $5 titled_document in
    	let full_document = end_root document_with_content in
    		print_list(rev(flatten(full_document)))
    }
;

def_image_size:
	LEFT_PARENTHESIS INTEGER COMA INTEGER RIGHT_PARENTHESIS {print_endline "size"; ($2, $4)}
;

content:
	declaration SEMICOLON {add_node !document $1}
	| declaration SEMICOLON content {add_node !document $1}
;

image_name:
	WORD {$1}
;

declaration:
	CIRCLE LEFT_PARENTHESIS dot COMA radius RIGHT_PARENTHESIS {
		let (cx, cy) = $3 in 
			print_endline cx;
			print_endline cy;
			print_endline $5;
			"test"
	}
;

dot:
	DOT LEFT_PARENTHESIS INTEGER COMA INTEGER RIGHT_PARENTHESIS {($3,$5)}
;

radius:
	RADIUS LEFT_PARENTHESIS INTEGER RIGHT_PARENTHESIS {$3}
;
