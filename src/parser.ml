type token =
  | EOF
  | MOT of (string)
  | INTEGER
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
# 2 "parser.mly"
open Fonctions;;

let ref nom_image = "";
let ref height = 0;
let ref width = 0;
let ref desc = "";
# 28 "parser.ml"
let yytransl_const = [|
    0 (* EOF *);
  258 (* INTEGER *);
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
  257 (* MOT *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\003\000\004\000\004\000\005\000\000\000"

let yylen = "\002\000\
\002\000\006\000\005\000\002\000\003\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\007\000\000\000\000\000\001\000\000\000\
\000\000\000\000\000\000\000\000\006\000\000\000\000\000\000\000\
\002\000\000\000\003\000\005\000"

let yydgoto = "\002\000\
\004\000\005\000\009\000\014\000\015\000"

let yysindex = "\255\255\
\254\254\000\000\001\255\000\000\003\000\246\254\000\000\004\255\
\002\255\250\254\007\255\008\255\000\000\005\255\255\254\253\254\
\000\000\007\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\009\255\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\251\255\000\000"

let yytablesize = 14
let yytable = "\001\000\
\003\000\006\000\007\000\008\000\010\000\011\000\012\000\013\000\
\016\000\017\000\018\000\019\000\020\000\004\000"

let yycheck = "\001\000\
\003\001\001\001\000\000\014\001\001\001\004\001\013\001\001\001\
\001\001\005\001\012\001\015\001\018\000\005\001"

let yynames_const = "\
  EOF\000\
  INTEGER\000\
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
  MOT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'def_image) in
    Obj.repr(
# 38 "parser.mly"
                (_1)
# 116 "parser.ml"
               : Interpret_func.t_expr list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'def_image_size) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'content) in
    Obj.repr(
# 42 "parser.mly"
                                                           (nom_image := _2)
# 125 "parser.ml"
               : 'def_image))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 46 "parser.mly"
                                                 (width := _2; height := _4)
# 133 "parser.ml"
               : 'def_image_size))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'declaration) in
    Obj.repr(
# 50 "parser.mly"
                       ()
# 140 "parser.ml"
               : 'content))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'declaration) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'content) in
    Obj.repr(
# 51 "parser.mly"
                                 ()
# 148 "parser.ml"
               : 'content))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 55 "parser.mly"
      ()
# 155 "parser.ml"
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
   (Parsing.yyparse yytables 1 lexfun lexbuf : Interpret_func.t_expr list)
