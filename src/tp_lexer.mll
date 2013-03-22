{
 open Tp_parser;;
}

let mot = ['a'-'z' 'A'-'Z']['a'-'z' 'A'-'Z' '0'-'9']*
let integer = ['0'-'9']*

rule token = parse
	| "/*" 			{comment lexbuf}
	
	| "image"		{IMAGE}
	| "{"			{BEGIN_BLOCK}
	| "}"			{END_BLOCK}
	| "("			{LEFT_PARENTHESIS}
	| ")"			{RIGHT_PARENTHESIS}
	| ';' 			{SEMICOLON}
	| ','			{COMA}
	
	
  	| mot as lxm {MOT(lxm)}
  	| integer as lxi {INTEGER(lxi)}
	
	
	
	| eof 			{print_endline "Fin de fichier" }	

and comment = parse
	| "*/" 			{ token lexbuf }
	| _ 			{ comment lexbuf }
	| eof 			{ print_endline "Fin de fichier" }
  
{}
