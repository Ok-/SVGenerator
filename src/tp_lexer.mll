{
	open Tp_parser;;
	
	let str_buffer = ref "";;
	let single_comment = ref "";;
	
	(* Element for parsing errors *)
	let invalid_token = ref ' ';;
	let line = ref 0;;
}

let word = ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9']*
let integer = ['0'-'9']+
let endline = ['\n']
let void = [' ' '\t']
let str_value = [^ '"' '\n']*
let other_token = [^ '"' ' ' '\t' '\n']*

rule token = parse
	| "/*" 				{multiline_comment lexbuf}
	| "//"				{single_comment := ""; single_line_comment lexbuf}
	
	| "image"			{print_endline "IMAGE"; IMAGE}
	| "description"		{print_endline "DESCRIPTION"; DESCRIPTION}
	| "dot"				{print_endline "DOT"; DOT}
	| "fill"			{print_endline "FILL"; FILL}
	| "stroke"			{print_endline "STROKE"; STROKE}
	| "line"			{print_endline "LINE"; LINE}
	| "circle"			{print_endline "CIRCLE"; CIRCLE}
	| "rectangle"		{print_endline "RECTANGLE"; RECTANGLE}
	| "text"			{print_endline "TEXT"; TEXT}
	| "polygon"			{print_endline "POLYGON"; POLYGON}
	| "radius"			{print_endline "RADIUS"; RADIUS}
	| "integer"			{print_endline "INTEGER_TYPE"; INTEGER_TYPE}
	
	| ":="				{print_endline "ASSIGNMENT"; ASSIGNMENT}
	| "draw"			{print_endline "DRAW"; DRAW}
	
	| "+"				{print_endline "PLUS"; PLUS}
	| "-"				{print_endline "MINUS"; MINUS}
	| "*"				{print_endline "ASTERISK"; ASTERISK}
	| "/"				{print_endline "SLASH"; SLASH}
	
	|  "if"				{print_endline "IF"; IF}
	|  "else"			{print_endline "ELSE"; ELSE}
	|  "="				{print_endline "EQUAL"; EQUAL}
	|  "<>"				{print_endline "DIFFERENT"; DIFFERENT}
	|  ">"				{print_endline "GT"; GT}
	|  ">="				{print_endline "GTE"; GTE}
	|  "<"				{print_endline "LT"; LT}
	|  "<="				{print_endline "LTE"; LTE}
	|  "or"				{print_endline "OR"; OR}
	|  "and"			{print_endline "AND"; AND}
	|  "not"			{print_endline "NOT"; NOT}
	|  "True"			{print_endline "TRUE"; TRUE}
	|  "False"			{print_endline "FALSE"; FALSE}
	
	| "["				{print_endline "BEGIN_CONDITION"; BEGIN_CONDITION}
	| "]"				{print_endline "END_CONDITION"; END_CONDITION}
	| "{"				{print_endline "BEGIN"; BEGIN_BLOCK}
	| "}"				{print_endline "END"; token lexbuf}
	| "("				{print_endline "LEFT"; LEFT_PARENTHESIS}
	| ")"				{print_endline "RIGHT"; RIGHT_PARENTHESIS}
	| ";" 				{print_endline "SEMICOLON"; SEMICOLON}
	| ","				{print_endline "COMA"; COMA}
	| '"'				{quoted_string lexbuf}
	
	| void				{token lexbuf}
	| endline			{line:=!line + 1; print_endline "NEW_LINE"; NEW_LINE}
  	| word as lxm 		{print_endline("word : " ^ lxm);WORD(lxm)}
  	| integer as lxi 	{print_endline("integer : " ^ lxi);INTEGER(lxi)}
	| _ as err 			{invalid_token := err; syntax_error lexbuf}
	
	| eof 				{print_endline "End of file"; EOF}

and quoted_string = parse
	| '"'				{STRINGVALUE(!str_buffer)}
	| eof				{EOF}
	| str_value as lxm 	{str_buffer := lxm; quoted_string lexbuf}
	
and single_line_comment = parse
	| endline			{ENDLINE_COMMENT(!single_comment)} 
	| eof				{EOF}
	| void				{single_line_comment lexbuf}
	| str_value as lxm 	{single_comment := lxm; single_line_comment lexbuf}

and multiline_comment = parse
	| "*/" 				{token lexbuf}
	| _ 				{multiline_comment lexbuf}
	| eof 				{print_endline "End of file"; EOF}

and syntax_error = parse
	| other_token as lxm	{
		print_endline("Syntax error at token '" ^ String.make 1 !invalid_token ^ lxm ^ "' line " ^ string_of_int(!line+1));
		token lexbuf
	}

{}
