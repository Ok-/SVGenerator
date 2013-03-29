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

let empty_list = [];;
let document = start_xml empty_list;;
# 29 "tp_parser.ml"
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
\001\000\002\000\004\000\005\000\005\000\003\000\006\000\006\000\
\006\000\006\000\007\000\009\000\009\000\008\000\000\000"

let yylen = "\002\000\
\002\000\006\000\005\000\002\000\003\000\001\000\006\000\006\000\
\006\000\006\000\006\000\004\000\002\000\004\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\015\000\000\000\006\000\000\000\001\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\002\000\000\000\003\000\000\000\000\000\000\000\000\000\000\000\
\005\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\008\000\000\000\
\007\000\009\000\000\000\013\000\010\000\000\000\000\000\000\000\
\011\000\014\000\012\000"

let yydgoto = "\002\000\
\004\000\005\000\007\000\010\000\018\000\019\000\029\000\042\000\
\045\000"

let yysindex = "\007\000\
\006\255\000\000\010\255\000\000\012\000\000\000\000\255\000\000\
\014\255\013\255\007\255\251\254\016\255\008\255\009\255\011\255\
\018\255\019\255\015\255\017\255\020\255\020\255\020\255\021\255\
\000\000\251\254\000\000\022\255\024\255\025\255\026\255\020\255\
\000\000\027\255\020\255\023\255\020\255\028\255\029\255\030\255\
\032\255\033\255\034\255\005\255\035\255\031\255\000\000\038\255\
\000\000\000\000\039\255\000\000\000\000\036\255\040\255\041\255\
\000\000\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\042\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\000\000\251\255\000\000\234\255\000\000\
\000\000"

let yytablesize = 55
let yytable = "\030\000\
\031\000\014\000\015\000\016\000\017\000\051\000\052\000\001\000\
\003\000\038\000\006\000\008\000\040\000\009\000\043\000\011\000\
\012\000\020\000\024\000\013\000\033\000\021\000\022\000\025\000\
\023\000\028\000\026\000\000\000\039\000\000\000\000\000\027\000\
\054\000\041\000\032\000\034\000\035\000\036\000\037\000\055\000\
\044\000\046\000\059\000\000\000\047\000\048\000\004\000\049\000\
\050\000\053\000\057\000\056\000\000\000\000\000\058\000"

let yycheck = "\022\000\
\023\000\007\001\008\001\009\001\010\001\001\001\002\001\001\000\
\003\001\032\000\001\001\000\000\035\000\014\001\037\000\002\001\
\004\001\002\001\001\001\013\001\026\000\014\001\014\001\005\001\
\014\001\006\001\012\001\255\255\002\001\255\255\255\255\015\001\
\002\001\011\001\014\001\014\001\013\001\013\001\013\001\002\001\
\013\001\013\001\002\001\255\255\015\001\014\001\005\001\015\001\
\015\001\015\001\015\001\013\001\255\255\255\255\015\001"

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
# 39 "tp_parser.mly"
               (())
# 146 "tp_parser.ml"
               : unit))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'image_name) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'def_image_size) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'content) in
    Obj.repr(
# 43 "tp_parser.mly"
                                                                  (
    	let (w,h) = _3 in
    	let empty_document = begin_root document w h in
    	let titled_document = add_title empty_document _2 in 
    	let document_with_content = _5 @ titled_document in
    	let full_document = end_root document_with_content in
    	let xml = rev(flatten(full_document)) in
    		print_xml xml;
    		print_file(concat_xml(xml))
    )
# 164 "tp_parser.ml"
               : 'def_image))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 56 "tp_parser.mly"
                                                         (_2, _4)
# 172 "tp_parser.ml"
               : 'def_image_size))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'declaration) in
    Obj.repr(
# 60 "tp_parser.mly"
                       (_1)
# 179 "tp_parser.ml"
               : 'content))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'declaration) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'content) in
    Obj.repr(
# 61 "tp_parser.mly"
                                 (_1 @ _3)
# 187 "tp_parser.ml"
               : 'content))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 65 "tp_parser.mly"
      (_1)
# 194 "tp_parser.ml"
               : 'image_name))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'dot) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'radius) in
    Obj.repr(
# 69 "tp_parser.mly"
                                                           (
		let (cx, cy) = _3 and r = _5 in
			add_circle empty_list cx cy r
	)
# 205 "tp_parser.ml"
               : 'declaration))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'dot) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'dot) in
    Obj.repr(
# 74 "tp_parser.mly"
                                                             (
		let (x_one, y_one) = _3 and (x_two, y_two) = _5 in
			add_rectangle empty_list x_one y_one x_two y_two
	)
# 216 "tp_parser.ml"
               : 'declaration))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'dot) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'dot) in
    Obj.repr(
# 79 "tp_parser.mly"
                                                        (
		let (x_one, y_one) = _3 and (x_two, y_two) = _5 in
			add_line empty_list x_one y_one x_two y_two
	)
# 227 "tp_parser.ml"
               : 'declaration))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'dot) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'text_optional) in
    Obj.repr(
# 84 "tp_parser.mly"
                                                                  (
		let text = _2 and (x, y) = _4 and (police, size) = _5 in
			add_text empty_list text x y police size
	)
# 239 "tp_parser.ml"
               : 'declaration))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 91 "tp_parser.mly"
                                                             (_3,_5)
# 247 "tp_parser.ml"
               : 'dot))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 95 "tp_parser.mly"
                        (_2, _4)
# 255 "tp_parser.ml"
               : 'text_optional))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 96 "tp_parser.mly"
                ("Verdana", _2)
# 262 "tp_parser.ml"
               : 'text_optional))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 99 "tp_parser.mly"
                                                   (_3)
# 269 "tp_parser.ml"
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
