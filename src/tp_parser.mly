%{
open Fonctions;;
open List;;
open Svg_builder;;

let height = ref "";;
let width = ref "";;
let document = start_xml();;
%}

%token EOF

%token <string> WORD
%token <string> INTEGER

%token IMAGE
%token BEGIN_BLOCK
%token END_BLOCK

%token POINT
%token RECTANGLE
%token CIRCLE
%token COULEUR
%token LINE
%token TEXT

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
    		begin_root document w h;
    		add_title document $2;
    		append $5 document;
    		end_root document;
    		print_list_of_list document;
    		print_endline $2
    }
;

def_image_size:
	LEFT_PARENTHESIS INTEGER COMA INTEGER RIGHT_PARENTHESIS {print_endline "size"; width := $2; height := $4; ($2, $4)}
;

content:
	declaration SEMICOLON {add_node document $1}
	| declaration SEMICOLON content {add_node document $1}
;

image_name:
	WORD {$1}
;

declaration:
	WORD {$1}
;
