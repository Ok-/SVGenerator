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

let nom_image = ref "";;
let height = ref "";;
let width = ref "";;
let desc = ref "";;
let content = ref "";;
# 30 "tp_parser.ml"
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
\000\000\000\000\000\000\008\000\001\000"

let yydgoto = "\002\000\
\004\000\000\000\000\000\000\000\000\000\000\000"

let yysindex = "\255\255\
\254\254\000\000\002\000\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000"

let yytablesize = 2
let yytable = "\001\000\
\003\000\005\000"

let yycheck = "\001\000\
\003\001\000\000"

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
    Obj.repr(
# 40 "tp_parser.mly"
           (print_endline "main")
# 109 "tp_parser.ml"
               : unit))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'image_name) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'def_image_size) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'content) in
    Obj.repr(
# 44 "tp_parser.mly"
                                                                  (print_endline _2)
# 118 "tp_parser.ml"
               : 'def_image))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 48 "tp_parser.mly"
                                                         (print_endline "size"; width := _2; height := _4; (_2, _4))
# 126 "tp_parser.ml"
               : 'def_image_size))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'declaration) in
    Obj.repr(
# 52 "tp_parser.mly"
                       (print_endline _1; [_1])
# 133 "tp_parser.ml"
               : 'content))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'declaration) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'content) in
    Obj.repr(
# 53 "tp_parser.mly"
                                 (print_endline _1; _1::_3)
# 141 "tp_parser.ml"
               : 'content))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 57 "tp_parser.mly"
      (_1)
# 148 "tp_parser.ml"
               : 'image_name))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 61 "tp_parser.mly"
      (_1)
# 155 "tp_parser.ml"
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
