%{
open Fonctions;;
open String;;
open List;;
open Svg_builder;;

let empty_list = [];;
let document = start_xml empty_list;;
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
	def_image EOF {()}
;

def_image:
    IMAGE image_name def_image_size BEGIN_BLOCK content END_BLOCK {
    	let (w,h) = $3 in
    	let empty_document = begin_root document w h in
    	let titled_document = add_title empty_document $2 in 
    	let document_with_content = $5 @ titled_document in
    	let full_document = end_root document_with_content in
    	let xml = rev(flatten(full_document)) in
    		print_xml xml;
    		print_file(concat_xml(xml))
    }
;

def_image_size:
	LEFT_PARENTHESIS INTEGER COMA INTEGER RIGHT_PARENTHESIS {$2, $4}
;

content:
	declaration SEMICOLON {$1}
	| declaration SEMICOLON content {$1 @ $3}
;

image_name:
	WORD {$1}
;

declaration:
	CIRCLE LEFT_PARENTHESIS dot COMA radius RIGHT_PARENTHESIS {
		let (cx, cy) = $3 and r = $5 in
			add_circle empty_list cx cy r
	}
	| RECTANGLE LEFT_PARENTHESIS dot COMA dot RIGHT_PARENTHESIS {
		let (cx_one, cy_one) = $3 and (cx_two, cy_two) = $5 in
			add_rectangle empty_list cx_one cy_one cx_two cy_two
	}
;

dot:
	DOT LEFT_PARENTHESIS INTEGER COMA INTEGER RIGHT_PARENTHESIS {$3,$5}
;

radius:
	RADIUS LEFT_PARENTHESIS INTEGER RIGHT_PARENTHESIS {$3}
;
