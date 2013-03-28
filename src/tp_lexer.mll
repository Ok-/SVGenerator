{
 open Tp_parser;;
}

let word = ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9']*
let integer = ['0'-'9']+
let void = ['\n' ' ' '\t']

rule token = parse
	| "/*" 			{comment lexbuf}
	
	| "image"		{print_endline "IMAGE"; IMAGE}
	| "{"			{print_endline "BEGIN"; BEGIN_BLOCK}
	| "}"			{print_endline "END"; END_BLOCK}
	| "("			{print_endline "LEFT"; LEFT_PARENTHESIS}
	| ")"			{print_endline "RIGHT"; RIGHT_PARENTHESIS}
	| ';' 			{print_endline "SEMICOLON"; SEMICOLON}
	| ','			{print_endline "COMA"; COMA}
	
	| void			{token lexbuf}
  	| word as lxm {WORD(lxm)}
  	| integer as lxi {print_endline("nombre : "^lxi);INTEGER(lxi)}
	
	| eof 			{print_endline "End of file"; EOF}	

and comment = parse
	| "*/" 			{ token lexbuf }
	| _ 			{ comment lexbuf }
	| eof 			{ print_endline "End of file"; EOF}
  
{}
