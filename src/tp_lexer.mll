{
	open Tp_parser;;
	
	let str_buffer = ref "";;
}

let word = ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9']*
let integer = ['0'-'9']+
let void = ['\n' ' ' '\t']
let str_value = [^ '"']*

rule token = parse
	| "/*" 			{comment lexbuf}
	
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
	| "}"				{print_endline "END"; END_BLOCK}
	| "("				{print_endline "LEFT"; LEFT_PARENTHESIS}
	| ")"				{print_endline "RIGHT"; RIGHT_PARENTHESIS}
	| ';' 				{print_endline "SEMICOLON"; SEMICOLON}
	| ','				{print_endline "COMA"; COMA}
	| '"'				{quoted_string lexbuf}
	
	| void				{token lexbuf}
  	| word as lxm 		{WORD(lxm)}
  	| integer as lxi 	{print_endline("nombre : "^lxi);INTEGER(lxi)}
	
	| eof 				{print_endline "End of file"; EOF}	

and quoted_string = parse
	| '"'				{STRINGVALUE(!str_buffer)}
	| eof				{EOF}
	| str_value as lxm 	{str_buffer := lxm; quoted_string lexbuf}

and comment = parse
	| "*/" 				{token lexbuf}
	| _ 				{comment lexbuf}
	| eof 				{print_endline "End of file"; EOF}
  
{}
