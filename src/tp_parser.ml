type token =
  | EOF
  | WORD of (string)
  | INTEGER of (string)
  | IMAGE
  | BEGIN_BLOCK
  | END_BLOCK
  | DOT
  | RECTANGLE
  | CIRCLE
  | LINE
  | TEXT
  | RADIUS
  | SEMICOLON
  | COMA
  | LEFT_PARENTHESIS
  | RIGHT_PARENTHESIS

open Parsing;;
# 2 "tp_parser.mly"
open Fonctions;;
open String;;
open List;;
open Svg_builder;;

let document = start_xml [];;
# 28 "tp_parser.ml"
let yytransl_const = [|
    0 (* EOF *);
  259 (* IMAGE *);
  260 (* BEGIN_BLOCK *);
  261 (* END_BLOCK *);
  262 (* DOT *);
  263 (* RECTANGLE *);
  264 (* CIRCLE *);
  265 (* LINE *);
  266 (* TEXT *);
  267 (* RADIUS *);
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
\001\000\002\000\004\000\005\000\005\000\003\000\006\000\007\000\
\008\000\000\000"

let yylen = "\002\000\
\002\000\006\000\005\000\002\000\003\000\001\000\006\000\006\000\
\004\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\010\000\000\000\006\000\000\000\001\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\002\000\000\000\003\000\000\000\000\000\005\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\007\000\
\000\000\000\000\008\000\009\000"

let yydgoto = "\002\000\
\004\000\005\000\007\000\010\000\015\000\016\000\023\000\029\000"

let yysindex = "\255\255\
\254\254\000\000\001\255\000\000\003\000\000\000\246\254\000\000\
\003\255\002\255\250\254\000\255\007\255\252\254\006\255\004\255\
\253\254\008\255\000\000\000\255\000\000\255\254\005\255\000\000\
\013\255\009\255\010\255\011\255\012\255\015\255\017\255\000\000\
\014\255\016\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\019\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000"

let yytablesize = 31
let yytable = "\001\000\
\003\000\006\000\008\000\009\000\011\000\012\000\013\000\014\000\
\017\000\018\000\019\000\021\000\025\000\022\000\027\000\020\000\
\033\000\026\000\034\000\028\000\024\000\000\000\030\000\004\000\
\031\000\000\000\032\000\000\000\035\000\000\000\036\000"

let yycheck = "\001\000\
\003\001\001\001\000\000\014\001\002\001\004\001\013\001\008\001\
\002\001\014\001\005\001\015\001\014\001\006\001\002\001\012\001\
\002\001\013\001\002\001\011\001\020\000\255\255\013\001\005\001\
\014\001\255\255\015\001\255\255\015\001\255\255\015\001"

let yynames_const = "\
  EOF\000\
  IMAGE\000\
  BEGIN_BLOCK\000\
  END_BLOCK\000\
  DOT\000\
  RECTANGLE\000\
  CIRCLE\000\
  LINE\000\
  TEXT\000\
  RADIUS\000\
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
# 38 "tp_parser.mly"
               (())
# 128 "tp_parser.ml"
               : unit))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'image_name) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'def_image_size) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'content) in
    Obj.repr(
# 42 "tp_parser.mly"
                                                                  (
    	let (w,h) = _3 in
    	let empty_document = begin_root document w h in
    	let titled_document = add_title empty_document _2 in 
    	let document_with_content = _5 @ titled_document in
    	let full_document = end_root document_with_content in
    		print_xml(rev(flatten(full_document)))
    )
# 144 "tp_parser.ml"
               : 'def_image))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 53 "tp_parser.mly"
                                                         (_2, _4)
# 152 "tp_parser.ml"
               : 'def_image_size))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'declaration) in
    Obj.repr(
# 57 "tp_parser.mly"
                       (_1)
# 159 "tp_parser.ml"
               : 'content))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'declaration) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'content) in
    Obj.repr(
# 58 "tp_parser.mly"
                                 (_1 @ _3)
# 167 "tp_parser.ml"
               : 'content))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 62 "tp_parser.mly"
      (_1)
# 174 "tp_parser.ml"
               : 'image_name))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'dot) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'radius) in
    Obj.repr(
# 66 "tp_parser.mly"
                                                           (
		let (cx, cy) = _3 and r = _5 in
			add_circle [] cx cy r
	)
# 185 "tp_parser.ml"
               : 'declaration))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 73 "tp_parser.mly"
                                                             (_3,_5)
# 193 "tp_parser.ml"
               : 'dot))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 77 "tp_parser.mly"
                                                   (_3)
# 200 "tp_parser.ml"
               : 'radius))
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
