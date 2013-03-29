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

(* Build police attribute for color *)
let rec build_fill_attribute fill_color =
	if fill_color = "" then ""
	else "fill=\"" ^ fill_color ^ "\" ";;

(* Build police attribute for color *)
let rec build_stroke_attribute stroke_color =
	if stroke_color = "" then ""
	else "stroke=\"" ^ stroke_color ^ "\" ";;

(* Add a circle node to document *)
(* TODO : manage color *)
let rec add_circle document cx cy r fill stroke =
	let node = "  <circle cx=\"" ^ cx ^ "\" cy=\"" ^ cy ^ "\" r=\"" ^ r ^ "\" "
	^ build_fill_attribute(fill)
	^ build_stroke_attribute(stroke)
	^ "/>\n" in
		add_node document node;;
		
(* Add a rectangle node to document *)
let rec add_rectangle document x_one y_one x_two y_two fill stroke =
	let w = abs(int_of_string(x_two) - int_of_string(x_one))
	and h = abs(int_of_string(y_two) - int_of_string(y_one)) in
		let node = "  <rect width=\"" ^ string_of_int(w) ^ "\" height=\"" ^ string_of_int(h) ^ "\" x=\"" ^ x_one ^ "\" y=\"" ^ y_one ^ "\" "
		^ build_fill_attribute(fill)
		^ build_stroke_attribute(stroke)
		^ "/>\n" in
			add_node document node;;

(* Add a line node to document *)
(* TODO : manage color *)
let rec add_line document x_one y_one x_two y_two fill stroke =
	let node = "  <line x1=\"" ^ x_one ^ "\" y1=\"" ^ y_one ^ "\" x2=\"" ^ x_two ^ "\" y2=\"" ^ y_two ^ "\" "
	^ build_fill_attribute(fill)
	^ build_stroke_attribute(stroke)
	^ "/>\n" in
		add_node document node;;

(* Build police attribute for text node *)
let build_police_attribute police =
	if police = "" then ""
	else "font-family=\"" ^ police ^ "\" ";;
	
(* Build size attribute for text node *)
let build_size_text_attribute size =
	if size < 0 then ""
	else "font-size=\"" ^ string_of_int(size) ^ "\" ";;

(* Add a text node to document *)
(* TODO : manage color *)
let rec add_text document text x y police size fill stroke =
	let node = "  <text x=\"" ^ x ^ "\" y=\"" ^ y ^ "\" "
		^ build_police_attribute(police)
		^ build_size_text_attribute(size)
		^ build_fill_attribute(fill)
		^ build_stroke_attribute(stroke)
		^ ">" ^ text ^ "</text>\n" in
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
