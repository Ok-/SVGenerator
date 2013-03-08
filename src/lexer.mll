{
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
  
  

{
let _ =
  if Array.length Sys.argv < 2
    then print_endline "Donnez un nom de fichier en argument" else
  let input_file = Sys.argv.(1) in
  if not (Sys.file_exists input_file)
    then print_endline "Ce fichier n'existe pas" else
  let lexbuf = Lexing.from_channel (open_in input_file) in
  token lexbuf;;
}
