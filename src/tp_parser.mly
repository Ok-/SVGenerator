%{
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

%token PLUS
%token MINUS
%token ASTERISK
%token SLASH

%token IF
%token ELSE
%token BEGIN_CONDITION
%token END_CONDITION

%token EQUAL
%token DIFFERENT
%token GT
%token GTE
%token LT
%token LTE
%token OR
%token AND
%token NOT
%token TRUE
%token FALSE

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
;

def_image:
    IMAGE STRINGVALUE def_image_size BEGIN_BLOCK NEW_LINE description content NEW_LINE {
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
		let lst = [add_endline_comment($3)] in
			if lst <> [] then
				let lst_xml = (lst :: $1) in
					lst_xml @ $4
			else $1 @ $4
	}
	
	| IF boolean_expression BEGIN_CONDITION NEW_LINE content END_CONDITION ELSE BEGIN_CONDITION NEW_LINE content END_CONDITION SEMICOLON NEW_LINE {
		if ($2) then $5
		else $10
	}
	
	| IF boolean_expression BEGIN_CONDITION NEW_LINE content END_CONDITION ELSE BEGIN_CONDITION NEW_LINE content END_CONDITION SEMICOLON NEW_LINE content {
		if ($2) then $5 @ $14
		else $10 @ $14
	}
	
	| IF boolean_expression BEGIN_CONDITION NEW_LINE content  END_CONDITION SEMICOLON NEW_LINE content {
		if ($2) then $5 @ $9
		else []
	}
;

boolean_expression:
	LEFT_PARENTHESIS boolean_expression EQUAL boolean_expression RIGHT_PARENTHESIS {$2 = $4}
	| LEFT_PARENTHESIS boolean_expression DIFFERENT boolean_expression RIGHT_PARENTHESIS {$2 <> $4}
	| LEFT_PARENTHESIS boolean_expression OR boolean_expression RIGHT_PARENTHESIS {$2 || $4}
	| LEFT_PARENTHESIS boolean_expression AND boolean_expression RIGHT_PARENTHESIS {$2 && $4}
	| LEFT_PARENTHESIS NOT boolean_expression RIGHT_PARENTHESIS {not $3}
	| LEFT_PARENTHESIS TRUE RIGHT_PARENTHESIS { true }
	| LEFT_PARENTHESIS FALSE RIGHT_PARENTHESIS { false }
	| TRUE { true }
	| FALSE { false }
	| LEFT_PARENTHESIS operation GT operation RIGHT_PARENTHESIS {$2 > $4}
	| LEFT_PARENTHESIS operation GTE operation RIGHT_PARENTHESIS {$2 >= $4}
	| LEFT_PARENTHESIS operation LT operation RIGHT_PARENTHESIS {$2 < $4}
	| LEFT_PARENTHESIS operation LTE operation RIGHT_PARENTHESIS {$2 <= $4}
	| LEFT_PARENTHESIS operation EQUAL operation RIGHT_PARENTHESIS {$2 = $4}
	| LEFT_PARENTHESIS operation DIFFERENT operation RIGHT_PARENTHESIS {$2 <> $4}
;



endline_comment:
	| ENDLINE_COMMENT {$1}
	| NEW_LINE {""}
;

operation:
	INTEGER PLUS operation {int_of_string($1) + $3}
	| INTEGER MINUS operation {int_of_string($1) - $3}
	| INTEGER ASTERISK operation {int_of_string($1) * $3}
	| INTEGER SLASH operation {int_of_string($1) / $3}
	| WORD PLUS operation {int_of_string(get_int_value !symbol_table $1) + $3}
	| WORD MINUS operation {int_of_string(get_int_value !symbol_table $1) - $3}
	| WORD ASTERISK operation {int_of_string(get_int_value !symbol_table $1) * $3}
	| WORD SLASH operation {int_of_string(get_int_value !symbol_table $1) / $3}
	| INTEGER {int_of_string($1)}
	| WORD {int_of_string(get_int_value !symbol_table $1)}
;

declaration:
	INTEGER_TYPE WORD ASSIGNMENT operation {
		symbol_table := (add_symbol !symbol_table $2 "integer" [string_of_int($4)] ("",""));
		[]
	}

	| DOT WORD ASSIGNMENT LEFT_PARENTHESIS dot RIGHT_PARENTHESIS {
		let (x,y) = $5 in
			symbol_table := (add_symbol !symbol_table $2 "dot" [x;y] ("",""));
			[]
	}

	| CIRCLE WORD ASSIGNMENT LEFT_PARENTHESIS WORD COMA WORD COMA color RIGHT_PARENTHESIS {
		let (cx, cy) = get_dot_values !symbol_table $5 
		and r = get_int_value !symbol_table $7
		and color = $9 in
			symbol_table := add_symbol !symbol_table $2 "circle" [cx;cy;r] color;
			[]
	}

	| CIRCLE WORD ASSIGNMENT LEFT_PARENTHESIS WORD COMA WORD RIGHT_PARENTHESIS {
		let (cx, cy) = get_dot_values !symbol_table $5 
		and r = get_int_value !symbol_table $7
		and color = ("", "") in
			symbol_table := add_symbol !symbol_table $2 "circle" [cx;cy;r] color;
			[]
	}
	
	| LINE WORD ASSIGNMENT LEFT_PARENTHESIS WORD COMA WORD COMA color RIGHT_PARENTHESIS {
		let (cx_one, cy_one) = get_dot_values !symbol_table $5
		and (cx_two, cy_two) = get_dot_values !symbol_table $7 
		and color = $9 in
			symbol_table := add_symbol !symbol_table $2 "line" [cx_one;cy_one;cx_two;cy_two] color;
			[]
	}
		
	| LINE WORD ASSIGNMENT LEFT_PARENTHESIS WORD COMA WORD RIGHT_PARENTHESIS {
		let (cx_one, cy_one) = get_dot_values !symbol_table $5
		and (cx_two, cy_two) = get_dot_values !symbol_table $7 
		and color = ("", "") in
			symbol_table := add_symbol !symbol_table $2 "line" [cx_one;cy_one;cx_two;cy_two] color;
			[]
	}
	
	| RECTANGLE WORD ASSIGNMENT LEFT_PARENTHESIS WORD COMA WORD COMA color RIGHT_PARENTHESIS {
		let (cx_one, cy_one) = get_dot_values !symbol_table $5
		and (cx_two, cy_two) = get_dot_values !symbol_table $7
		and color = $9 in
			symbol_table := add_symbol !symbol_table $2 "rectangle" [cx_one;cy_one;cx_two;cy_two] color;
			[]
	}
		
	| RECTANGLE WORD ASSIGNMENT LEFT_PARENTHESIS WORD COMA WORD RIGHT_PARENTHESIS {
		let (cx_one, cy_one) = get_dot_values !symbol_table $5
		and (cx_two, cy_two) = get_dot_values !symbol_table $7
		and color = ("", "") in
			symbol_table := add_symbol !symbol_table $2 "rectangle" [cx_one;cy_one;cx_two;cy_two] color;
			[]
	}
	
	| TEXT WORD ASSIGNMENT LEFT_PARENTHESIS STRINGVALUE COMA WORD RIGHT_PARENTHESIS { 
		let (x, y) = get_dot_values !symbol_table $7
		and color = ("", "") in
			symbol_table := add_symbol !symbol_table $2 "text" [$5; x; y; "-1"] color;
			[]
	}
	
	| TEXT WORD ASSIGNMENT LEFT_PARENTHESIS STRINGVALUE COMA WORD COMA color RIGHT_PARENTHESIS {
		let (x, y) = get_dot_values !symbol_table $7
		and color = $9 in
			symbol_table := add_symbol !symbol_table $2 "text" [$5; x; y; "-1"] color;
			[]
	}
	
	| TEXT WORD ASSIGNMENT LEFT_PARENTHESIS STRINGVALUE COMA WORD COMA WORD COMA color RIGHT_PARENTHESIS {
		let (x, y) = get_dot_values !symbol_table $7 
		and size = get_int_value !symbol_table $9
		and color = ("", "") in
			symbol_table := add_symbol !symbol_table $2 "text" [$5; x; y; size] color;
			[]
	}
	
	| TEXT WORD ASSIGNMENT LEFT_PARENTHESIS STRINGVALUE COMA WORD COMA WORD RIGHT_PARENTHESIS {
		let (x, y) = get_dot_values !symbol_table $7 
		and size = get_int_value !symbol_table $9
		and color = ("", "") in
			symbol_table := add_symbol !symbol_table $2 "text" [$5; x; y; size] color;
			[]
	}
	
	| POLYGON WORD ASSIGNMENT LEFT_PARENTHESIS WORD dots_list RIGHT_PARENTHESIS {
		let (dots_list, color) = $6
		and dot_data = get_dot_values !symbol_table $5 in
		let (x, y) = dot_data in
		let dots = (x::y::dots_list) in
			symbol_table := add_symbol !symbol_table $2 "polygon" dots color;
			[]
	}
	
	| DRAW WORD {
		let element = assoc $2 !symbol_table in
			let symbol_type = hd(hd(element)) and symbol_data = hd(tl(element)) and
			(fill, stroke) = (get_colors !symbol_table $2) in
				match symbol_type with
				| "line" 		-> (add_line empty_list symbol_data fill stroke)
				| "circle"		-> (add_circle empty_list symbol_data fill stroke)
				| "rectangle" 	-> (add_rectangle empty_list symbol_data fill stroke)
				| "text" 		-> (add_text empty_list symbol_data fill stroke)
				| "polygon" 		-> (add_polygon empty_list symbol_data fill stroke)
				| _ -> (print_endline "Nothing to draw."; [])
				
	}
;

dots_list:
	COMA WORD dots_list {
		let (dots_list, color) = $3 
		and dot_data = get_dot_values !symbol_table $2 in
		let (x, y) = dot_data in
			((x::y::dots_list), color)
	}
	
	| COMA WORD {
		let dot_data = get_dot_values !symbol_table $2 in
		let (x, y) = dot_data in
			[x;y], ("", "")
	}
	
	| COMA WORD COMA color {
		let dot_data = get_dot_values !symbol_table $2 in
		let (x, y) = dot_data in
			[x;y], $4
	}
;

color:
	FILL LEFT_PARENTHESIS WORD RIGHT_PARENTHESIS {$3, ""}
	| STROKE LEFT_PARENTHESIS WORD RIGHT_PARENTHESIS {"", $3}
	| FILL LEFT_PARENTHESIS WORD RIGHT_PARENTHESIS COMA STROKE LEFT_PARENTHESIS WORD RIGHT_PARENTHESIS {$3, $8}
	| STROKE LEFT_PARENTHESIS WORD RIGHT_PARENTHESIS COMA FILL LEFT_PARENTHESIS WORD RIGHT_PARENTHESIS {$8, $3}
;

dot:
	INTEGER COMA INTEGER {$1,$3}
	| INTEGER COMA WORD {$1,(get_int_value !symbol_table $3)}
	| WORD COMA INTEGER {(get_int_value !symbol_table $1),$3}
	| WORD COMA WORD {(get_int_value !symbol_table $1),(get_int_value !symbol_table $3)}
;

radius:
	RADIUS LEFT_PARENTHESIS INTEGER RIGHT_PARENTHESIS {$3}
;
