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

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> unit
