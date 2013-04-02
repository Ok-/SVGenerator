%{
	open Fonctions;;
	open String;;
	open List;;
	open Svg_builder;;

	let empty_list = [];;
	let document = start_xml empty_list;;
	let symbol_table = ref [];;
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
%token INTEGER_TYPE
%token ASSIGNMENT
%token RADIUS
%token FILL
%token STROKE
%token DRAW

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

description:
	DESCRIPTION LEFT_PARENTHESIS STRINGVALUE RIGHT_PARENTHESIS SEMICOLON endline_comment {$3, $6}
	| DESCRIPTION LEFT_PARENTHESIS STRINGVALUE RIGHT_PARENTHESIS SEMICOLON {$3, ""}
;

content:
	declaration SEMICOLON endline_comment {
		[add_endline_comment($3)] :: $1
	}
	
	| declaration SEMICOLON endline_comment content {
		let lst = ([add_endline_comment($3)] :: $1) in
			if lst <> [] then
				lst @ $4
			else $4
	}
;

endline_comment:
	| ENDLINE_COMMENT {$1}
	| NEW_LINE {""}
;

declaration:
	INTEGER_TYPE WORD ASSIGNMENT INTEGER {
		symbol_table := (add_symbol !symbol_table $2 "integer" [$4]);
		[]
	}

	| DOT WORD ASSIGNMENT LEFT_PARENTHESIS INTEGER COMA INTEGER RIGHT_PARENTHESIS {
		symbol_table := (add_symbol !symbol_table $2 "dot" [$5;$7]);
		[]
	}

	| CIRCLE WORD ASSIGNMENT LEFT_PARENTHESIS circle_data RIGHT_PARENTHESIS {
		let (data_dot, r, data_circle) = $5 in
		let (cx, cy) = data_dot and (fill, stroke) = data_circle in
			symbol_table := add_symbol !symbol_table $2 "circle" [cx;cy;r];
			[]
	}
	
	| LINE WORD ASSIGNMENT LEFT_PARENTHESIS line_data RIGHT_PARENTHESIS {
		let (data_dot_one, data_dot_two, data_circle) = $5 in
		let (cx_one, cy_one) = data_dot_one
		and (cx_two, cy_two) = data_dot_two
		and (fill, stroke) = data_circle in
			symbol_table := add_symbol !symbol_table $2 "line" [cx_one;cy_one;cx_two;cy_two];
			[]
	}
	
	| DRAW WORD {
		let element = assoc $2 !symbol_table in
			let symbol_type = hd(hd(element)) and symbol_data = hd(tl(element)) in
				match symbol_type with
				| "circle"		-> (add_circle empty_list symbol_data "" "")
				| "line" 		-> (add_line empty_list symbol_data "" "")
				| _ -> (print_endline "Nothing to draw."; [])
				
	}
;

polygon_data:
	dot dots_list {
		let (dots_list, color) = $2 in
			(($1::dots_list), color)
	}
;

dots_list:
	COMA dot dots_list {
		let (dots_list, color) = $3 in
			(($2::dots_list), color)
	}
	
	| COMA dot {[$2], ("", "")}
	| COMA dot COMA color {[$2], $4}

line_data:
	WORD COMA WORD COMA color {
		let position_one = get_dot_values !symbol_table $1 
		and position_two = get_dot_values !symbol_table $3 in
			position_one, position_two, $5
	}
	
	| WORD COMA WORD {
		let position_one = get_dot_values !symbol_table $1 
		and position_two = get_dot_values !symbol_table $3 in
			position_one, position_two, ("", "")
	}
;

circle_data:
	WORD COMA WORD COMA color {
		let position = get_dot_values !symbol_table $1 
		and r = get_radius_value !symbol_table $3 in
			position, r, $5
	}
	| WORD COMA radius {
		let position = get_dot_values !symbol_table $1 in
			position, $3, ("", "")
	}
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
