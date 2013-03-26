open Fonctions;;
open Tp_parser;;

  (*
let _ =
  if Array.length Sys.argv < 2
    then print_endline "Donnez un nom de fichier en argument" else
  let input_file = Sys.argv.(1) in
  if not (Sys.file_exists input_file)
    then print_endline "Ce fichier n'existe pas" else
  let lexbuf = Lexing.from_channel (open_in input_file) in
  token lexbuf;;
  *)  

  
let _ =
	if Array.length Sys.argv < 2
	then print_endline "Donnez un nom de fichier" else
	let input_file = Sys.argv.(1) in
	if not (Sys.file_exists input_file)
	then print_endline "Ce fichier n'existe pas" else
	let lexbuf = Lexing.from_channel (open_in input_file) in
	let m = Tp_parser.main Tp_lexer.token lexbuf in
	print_endline "test";;
