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
%token <string> STRINGVALUE
%token <string> ENDLINE_COMMENT

%token IMAGE
%token BEGIN_BLOCK
%token END_BLOCK

%token DOT
%token DESCRIPTION
%token RECTANGLE
%token CIRCLE
%token LINE
%token TEXT
%token POLYGON
%token RADIUS
%token FILL
%token STROKE

%token SEMICOLON
%token COMA
%token QUOTE
%token LEFT_PARENTHESIS
%token RIGHT_PARENTHESIS
%token SINGLE_LINE_COMMENT
%token NEW_LINE

%start main
%type <unit> main


%%

main:
	def_image EOF {()}
	| def_image NEW_LINE def_image EOF {()}
;

def_image:
    IMAGE image_name def_image_size BEGIN_BLOCK NEW_LINE description content NEW_LINE {
    	let (w,h) = $3 in
    	let empty_document = begin_root document w h in
    	let titled_document = add_title empty_document $2 in 
    	let (description_str, comment_str) = $6 in
    	let titled_document_with_comment = ([add_endline_comment(comment_str)] :: titled_document) in
    	let document_with_description = add_description titled_document_with_comment description_str in
    	let document_with_content = rev($7) @ document_with_description in
    	let full_document = end_root document_with_content in
    	let xml = rev(flatten(full_document)) in
    		print_xml xml;
    		print_file(concat_xml(xml), $2)
    }
;

image_name:
	STRINGVALUE {$1}
;

def_image_size:
	LEFT_PARENTHESIS INTEGER COMA INTEGER RIGHT_PARENTHESIS {$2, $4}
;

content:
	declaration SEMICOLON endline_comment {
		[add_endline_comment($3)] :: $1
	}
	
	| declaration SEMICOLON endline_comment content {
		let lst = ([add_endline_comment($3)] :: $1) in
			lst @ $4
	}
;

endline_comment:
	| ENDLINE_COMMENT {$1}
	| NEW_LINE {""}
;

description:
	DESCRIPTION LEFT_PARENTHESIS STRINGVALUE RIGHT_PARENTHESIS SEMICOLON endline_comment {$3, $6}
	| DESCRIPTION LEFT_PARENTHESIS STRINGVALUE RIGHT_PARENTHESIS SEMICOLON {$3, ""}
;

declaration:
	CIRCLE LEFT_PARENTHESIS circle_data RIGHT_PARENTHESIS {
		let (data_dot, r, data_circle) = $3 in
		let (cx, cy) = data_dot and (fill, stroke) = data_circle in
			add_circle empty_list cx cy r fill stroke
	}
	
	| RECTANGLE LEFT_PARENTHESIS rectangle_data RIGHT_PARENTHESIS {
		let (data_dot_one, data_dot_two, data_circle) = $3 in
		let (x_one, y_one) = data_dot_one and (x_two, y_two) = data_dot_two and (fill, stroke) = data_circle in
			add_rectangle empty_list x_one y_one x_two y_two fill stroke
	}
	
	| LINE LEFT_PARENTHESIS line_data RIGHT_PARENTHESIS {
		let (data_dot_one, data_dot_two, data_circle) = $3 in
		let (x_one, y_one) = data_dot_one and (x_two, y_two) = data_dot_two and (fill, stroke) = data_circle in
			add_line empty_list x_one y_one x_two y_two fill stroke
	}
	
	| TEXT LEFT_PARENTHESIS STRINGVALUE COMA text_options RIGHT_PARENTHESIS {
		let text = $3 and (data_dot, police, size, color_data) = $5 in
		let (x, y) = data_dot and (fill, stroke) = color_data in 
			add_text empty_list text x y police size fill stroke
	}
	
	| POLYGON LEFT_PARENTHESIS polygon_data RIGHT_PARENTHESIS {
		let (dots, color_data) = $3 in
		let (fill, stroke) = color_data in
			add_polygon empty_list dots fill stroke
	}
;

polygon_data:
	dot dots_list {
		let (dots_list, color) = $2 in
			(($1::dots_list), color)
	}
;

dots_list: //$2::$3, ("", "")
	COMA dot dots_list {
		let (dots_list, color) = $3 in
			(($2::dots_list), color)
	}
	
	| COMA dot {[$2], ("", "")}
	| COMA dot COMA color {[$2], $4}

line_data:
	dot COMA dot COMA color {$1, $3, $5}
	| dot COMA dot {$1, $3, ("", "")}
;

circle_data:
	dot COMA radius COMA color {$1, $3, $5}
	| dot COMA radius {$1, $3, ("", "")}
;

rectangle_data:
	dot COMA dot COMA color {$1, $3, $5}
	| dot COMA dot {$1, $3, ("", "")}
;

color:
	FILL LEFT_PARENTHESIS WORD RIGHT_PARENTHESIS {$3, ""}
	| STROKE LEFT_PARENTHESIS WORD RIGHT_PARENTHESIS {"", $3}
	| FILL LEFT_PARENTHESIS WORD RIGHT_PARENTHESIS COMA STROKE LEFT_PARENTHESIS WORD RIGHT_PARENTHESIS {$3, $8}
	| STROKE LEFT_PARENTHESIS WORD RIGHT_PARENTHESIS COMA FILL LEFT_PARENTHESIS WORD RIGHT_PARENTHESIS {$8, $3}
;

dot:
	DOT LEFT_PARENTHESIS INTEGER COMA INTEGER RIGHT_PARENTHESIS {$3,$5}
;

text_options:
	dot COMA WORD COMA INTEGER COMA color {$1, $3, int_of_string($5), $7}
	| dot COMA WORD COMA INTEGER {$1, $3, int_of_string($5), ("", "")}
	| dot COMA INTEGER COMA color {$1, "", int_of_string($3), $5}
	| dot COMA INTEGER {$1, "", int_of_string($3), ("", "")}
	| dot COMA WORD COMA color {$1, $3, -1, $5}
	| dot COMA WORD {$1, $3, -1, ("", "")}
	| dot COMA color {$1, "", -1, $3}
	| dot {$1, "", -1, ("", "")}

radius:
	RADIUS LEFT_PARENTHESIS INTEGER RIGHT_PARENTHESIS {$3}
;
