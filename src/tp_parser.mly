%{
open Fonctions;;
open List;;

let nom_image = ref "";;
let height = ref "";;
let width = ref "";;
let desc = ref "";;
let content = ref "";;
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
	def_image EOF {print_endline "MSG"; $1}
;

def_image:
    IMAGE image_name def_image_size BEGIN_BLOCK content END_BLOCK {print_endline $2}
;

def_image_size:
	LEFT_PARENTHESIS INTEGER COMA INTEGER RIGHT_PARENTHESIS {print_endline "size"; width := $2; height := $4; ($2, $4)}
;

content:
	declaration SEMICOLON {print_endline $1; [$1]}
	| declaration SEMICOLON content {print_endline $1; $1::$3}
;

image_name:
	WORD {$1}
;

declaration:
	WORD {$1}
;
