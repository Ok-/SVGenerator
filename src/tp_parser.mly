%{
open Fonctions;;

let nom_image = ref "";;
let height = ref 0;;
let width = ref 0;;
let desc = ref "";;
let content = ref "";;
%}

%token EOF

%token <string> MOT
%token <int> INTEGER

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
%type <Fonctions.t_modules> main


%%

main:
  def_image EOF {$1}
;

def_image:
    IMAGE MOT def_image_size BEGIN_BLOCK content END_BLOCK {nom_image := $2; content := $5}
;

def_image_size:
	LEFT_PARENTHESIS MOT COMA MOT RIGHT_PARENTHESIS {width := $2; height := $4; (width, height) }
;

content:
	declaration SEMICOLON {declaration := $1}
	| declaration SEMICOLON content {declaration := $1; declaration := $3}
;

declaration:
	MOT {[$1]}
;
