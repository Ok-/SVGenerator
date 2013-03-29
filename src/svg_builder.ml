open List;;
open Printf;;

let output_file = "output.svg";;

(* type xml = string list list;; *)

(* Initialize xml doc *)
let rec start_xml document = 
	let node = ["<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"] in
		node::document;;

(* Build the beginning of the root node of the svg document *)
let rec begin_root document w h =
	let root = "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\""^w^"\" height=\""^h^"\">\n" in
		[root]::document;;
		
(* Build the end of the root of the svg document *)
let rec end_root document =
	["</svg>\n"]::document;;

(* Add node to document *)
let rec add_node document node =
	[node]::document;;
		
(* Add a title node to document *)
let rec add_title document title =
	let node = "  <title>"^title^"</title>\n" in
		add_node document node;;

(* Add a circle node to document *)
(* TODO : manage color *)
let rec add_circle document cx cy r =
	let node = "  <circle cx=\"" ^ cx ^ "\" cy=\"" ^ cy ^ "\" r=\"" ^ r ^ "\" fill=\"black\"/>\n" in
		add_node document node;;
		
(* Add a rectangle node to document *)
(* TODO : manage color *)
let rec add_rectangle document cx_one cy_one cx_two cy_two =
	let w = abs(int_of_string(cx_two) - int_of_string(cx_one))
	and h = abs(int_of_string(cy_two) - int_of_string(cy_one)) in
		let node = "  <rect width=\"" ^ string_of_int(w) ^ "\" height=\"" ^ string_of_int(h) ^ "\" x=\"" ^ cx_one ^ "\" y=\"" ^ cy_one ^ "\" fill=\"black\"/>\n" in
			add_node document node;;

(* Concat xml nodes in a string *)
let rec concat_xml xml =
	if xml = [] then ""
	else hd(xml)^concat_xml(tl(xml))

(* Print document *)
let rec print_xml = function 
[] -> ()
| e::l -> print_string e ; print_xml l

(* Write message to file *)
let rec print_file xml =
	let oc = open_out output_file in
	fprintf oc "%s\n" xml;   
	close_out oc;;
