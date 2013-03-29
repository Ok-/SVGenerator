open List;;

type xml = string list list;;

(* Initialize xml doc *)
let rec start_xml() = 
	let node = ["<?xml version=\"1.0\" encoding=\"utf-8\"?>"]
	and document = [] in
		node::document;;

(* Build the beginning of the root node of the svg document *)
let rec begin_root document w h =
	let root = "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\""^w^"\" height=\""^h^"\">" in
		[root]::document;;
		
(* Build the end of the root of the svg document *)
let rec end_root document =
	("</svg>"::[])::document;;

(* Add node to document *)
let rec add_node document node =
	[node]::document;;
		
(* Add a title node to document *)
let rec add_title document title =
	let node = "  <title>"^title^"</title>" in
		add_node document node;;

(* Add a circle node to document *)
(* TODO : manage color *)
let rec add_circle(document, cx, cy, r) =
	let node = "  <circle cx=\"" ^ cx ^ "\" cy=\"" ^ cy ^ "\" r=\"" ^ r ^ "\" fill=\"black\"/>" in
		add_node document node;;


(* Print document *)
let rec print_xml l =
	if l = [] then ()
	else if tl(l) = [] then print_endline(hd(l))
	else
		print_endline(hd(l));
		print_xml(tl(l));;
		
let rec print_list = function 
[] -> ()
| e::l -> print_string e ; print_string " " ; print_list l
(*
let rec print_list_of_list ll =
	if ll = [] then ()
	else if tl(ll) = [] then print_list(hd(ll))
	else
		print_list(hd(ll));
		print_list_of_list(tl(ll));;
*)

(* 
print_xml(rev(concat(document)));
add_circle(document, string_of_int(cx), string_of_int(cy), string_of_int($5))
*)
