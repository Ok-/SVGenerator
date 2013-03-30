{
	open Tp_parser;;
	
	let str_buffer = ref "";;
	let single_comment = ref "";;
}

let word = ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9']*
let integer = ['0'-'9']+
let endline = ['\n']
let void = [' ' '\t']
let str_value = [^ '"' '\n']*

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
	| "radius"			{print_endline "RADIUS"; RADIUS}
	
	| "{"				{print_endline "BEGIN"; BEGIN_BLOCK}
	| "}"				{print_endline "END"; token lexbuf}
	| "("				{print_endline "LEFT"; LEFT_PARENTHESIS}
	| ")"				{print_endline "RIGHT"; RIGHT_PARENTHESIS}
	| ";" 				{print_endline "SEMICOLON"; SEMICOLON}
	| ","				{print_endline "COMA"; COMA}
	| '"'				{quoted_string lexbuf}
	
	| void				{token lexbuf}
	| endline			{print_endline "NEW_LINE"; NEW_LINE}
  	| word as lxm 		{WORD(lxm)}
  	| integer as lxi 	{print_endline("nombre : "^lxi);INTEGER(lxi)}
	
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
  
{}
