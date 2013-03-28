type token =
  | EOF
  | WORD of (string)
  | INTEGER of (string)
  | IMAGE
  | BEGIN_BLOCK
  | END_BLOCK
  | POINT
  | RECTANGLE
  | CIRCLE
  | COULEUR
  | LINE
  | TEXT
  | SEMICOLON
  | COMA
  | LEFT_PARENTHESIS
  | RIGHT_PARENTHESIS

open Parsing;;
# 2 "tp_parser.mly"
open Fonctions;;
open List;;
open Svg_builder;;

let height = ref "";;
let width = ref "";;
let document = start_xml();;
# 29 "tp_parser.ml"
let yytransl_const = [|
    0 (* EOF *);
  259 (* IMAGE *);
  260 (* BEGIN_BLOCK *);
  261 (* END_BLOCK *);
  262 (* POINT *);
  263 (* RECTANGLE *);
  264 (* CIRCLE *);
  265 (* COULEUR *);
  266 (* LINE *);
  267 (* TEXT *);
  268 (* SEMICOLON *);
  269 (* COMA *);
  270 (* LEFT_PARENTHESIS *);
  271 (* RIGHT_PARENTHESIS *);
    0|]

let yytransl_block = [|
  257 (* WORD *);
  258 (* INTEGER *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\004\000\005\000\005\000\003\000\006\000\000\000"

let yylen = "\002\000\
\002\000\006\000\005\000\002\000\003\000\001\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\008\000\000\000\006\000\000\000\001\000\
\000\000\000\000\000\000\000\000\000\000\007\000\000\000\000\000\
\000\000\002\000\000\000\003\000\005\000"

let yydgoto = "\002\000\
\004\000\005\000\007\000\010\000\015\000\016\000"

let yysindex = "\255\255\
\254\254\000\000\001\255\000\000\003\000\000\000\246\254\000\000\
\003\255\002\255\250\254\007\255\008\255\000\000\004\255\255\254\
\253\254\000\000\007\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\009\255\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\000\000\250\255\000\000"

let yytablesize = 14
let yytable = "\001\000\
\003\000\006\000\008\000\009\000\011\000\012\000\013\000\014\000\
\018\000\017\000\019\000\020\000\021\000\004\000"

let yycheck = "\001\000\
\003\001\001\001\000\000\014\001\002\001\004\001\013\001\001\001\
\005\001\002\001\012\001\015\001\019\000\005\001"

let yynames_const = "\
  EOF\000\
  IMAGE\000\
  BEGIN_BLOCK\000\
  END_BLOCK\000\
  POINT\000\
  RECTANGLE\000\
  CIRCLE\000\
  COULEUR\000\
  LINE\000\
  TEXT\000\
  SEMICOLON\000\
  COMA\000\
  LEFT_PARENTHESIS\000\
  RIGHT_PARENTHESIS\000\
  "

let yynames_block = "\
  WORD\000\
  INTEGER\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'def_image) in
    Obj.repr(
# 39 "tp_parser.mly"
               (print_endline "Start"; _1)
# 117 "tp_parser.ml"
               : unit))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'image_name) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'def_image_size) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'content) in
    Obj.repr(
# 43 "tp_parser.mly"
                                                                  (
    	let (w,h) = _3 in
    		begin_root document w h;
    		add_title document _2;
    		append _5 document;
    		end_root document;
    		print_list_of_list document;
    		print_endline _2
    )
# 134 "tp_parser.ml"
               : 'def_image))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 55 "tp_parser.mly"
                                                         (print_endline "size"; width := _2; height := _4; (_2, _4))
# 142 "tp_parser.ml"
               : 'def_image_size))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'declaration) in
    Obj.repr(
# 59 "tp_parser.mly"
                       (add_node document _1)
# 149 "tp_parser.ml"
               : 'content))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'declaration) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'content) in
    Obj.repr(
# 60 "tp_parser.mly"
                                 (add_node document _1)
# 157 "tp_parser.ml"
               : 'content))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 64 "tp_parser.mly"
      (_1)
# 164 "tp_parser.ml"
               : 'image_name))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 68 "tp_parser.mly"
      (_1)
# 171 "tp_parser.ml"
               : 'declaration))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : unit)
