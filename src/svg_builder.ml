open List;;
open Printf;;
open String;;

(* ====== Functions to get data from symbol table ====== *)

(* Print a list of strings *)
let rec print_list = function 
[] -> ()
| e::l -> print_string (e ^ " ") ; print_list l

(* Check if a symbol already exists in the table *)
let rec check_symbol new_symbol_name symbol =
	let (name, data) = symbol in
		new_symbol_name = name;;

(* Add or replace a symbol in the symbol table *)
let rec add_symbol symbol_table symbol_name symbol_type values_list colors =
	let (fill, stroke) = colors in
		if (exists (check_symbol symbol_name) symbol_table) then
			let new_table = (remove_assoc symbol_name symbol_table) in
				(symbol_name, [[symbol_type]; values_list; [fill; stroke]]) :: symbol_table
		else 
			(symbol_name, [[symbol_type]; values_list; [fill; stroke]]) :: symbol_table;;

(* Get dot x and y values *)
let rec get_dot_values symbol_table symbol_name =
	let dot_data = assoc symbol_name symbol_table in
		let position = hd(tl(dot_data)) in
			(print_list position;
			(hd position), (nth position 1));;

(* Get radius value *)
let rec get_int_value symbol_table symbol_name =
	let dot_data = assoc symbol_name symbol_table in
		let position = hd(tl(dot_data)) in
			(print_list position;
			(hd position));;

(* Get radius value *)
let rec get_colors symbol_table symbol_name =
	let shape_data = assoc symbol_name symbol_table in
		let colors = (nth shape_data 2) in
			print_list colors;
			(hd colors), (nth colors 1);;

(* ================================================================================ *)	


(* ====== Functions to build xml file (svg) ====== *)

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
	let node = "  <title>" ^ title ^ "</title>\n" in
		add_node document node;;
		
(* Add a description node to document *)
let rec add_description document description =
	let node = "  <desc>" ^ description ^ "</desc>\n" in
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
let rec add_circle document circle_data fill stroke =
	let node = "  <circle cx=\"" ^ (hd circle_data) ^ "\" cy=\"" ^ (nth circle_data 1) ^ "\" r=\"" ^ (nth circle_data 2) ^ "\" "
	^ build_fill_attribute(fill)
	^ build_stroke_attribute(stroke)
	^ "/>\n" in
		add_node document node;;
		
(* Add a rectangle node to document *)
let rec add_rectangle document rectangle_data fill stroke =
	let x_one = (hd rectangle_data)
	and y_one = (nth rectangle_data 1)
	and x_two = (nth rectangle_data 2)
	and y_two = (nth rectangle_data 3) in
		let w = abs(int_of_string(x_two) - int_of_string(x_one))
		and h = abs(int_of_string(y_two) - int_of_string(y_one)) in
			let node = "  <rect width=\"" ^ string_of_int(w) ^ "\" height=\"" ^ string_of_int(h) ^ "\" x=\"" ^ x_one ^ "\" y=\"" ^ y_one ^ "\" "
			^ build_fill_attribute(fill)
			^ build_stroke_attribute(stroke)
			^ "/>\n" in
				add_node document node;;

(* Add a line node to document *)
let rec add_line document line_data fill stroke =
	let x_one = (hd line_data)
	and y_one = (nth line_data 1)
	and x_two = (nth line_data 2)
	and y_two = (nth line_data 3) in
		let node = "  <line x1=\"" ^ x_one ^ "\" y1=\"" ^ y_one ^ "\" x2=\"" ^ x_two ^ "\" y2=\"" ^ y_two ^ "\" "
		^ build_fill_attribute(fill)
		^ build_stroke_attribute(stroke)
		^ "/>\n" in
			add_node document node;;

(* Build points attribute for polygon node *)
let rec build_dots dots = 
	if dots = [] then ""
	else if tl(dots) = [] then ""
	else let x = hd(dots)
		and y = hd(tl(dots)) in
		" " ^ x ^ "," ^ y ^ " " ^ build_dots(tl(tl(dots)));;

(* Add a polygon node to document *)
let rec add_polygon document dots fill stroke =
	let node = "  <polygon points=\"" ^ build_dots dots ^ "\" "
	^ build_fill_attribute(fill)
	^ build_stroke_attribute(stroke)
	^ "/>\n" in
		add_node document node;;
	
(* Build size attribute for text node *)
let build_size_text_attribute size =
	if size < 0 then ""
	else "font-size=\"" ^ string_of_int(size) ^ "\" ";;

(* Add a text node to document *)
let rec add_text document text_data fill stroke =
	let text = (hd text_data)
	and x = (nth text_data 1)
	and y = (nth text_data 2)
	and size = (nth text_data 3) in
		let node = "  <text x=\"" ^ x ^ "\" y=\"" ^ y ^ "\" "
			^ build_size_text_attribute(int_of_string(size))
			^ build_fill_attribute(fill)
			^ build_stroke_attribute(stroke)
			^ ">" ^ text ^ "</text>\n" in
				add_node document node;;

(* Build comment node in the document *)
let rec add_endline_comment comment =
	if comment = "" then ""
	else "  <!-- " ^ comment ^ " -->\n"

(* Concat xml nodes in a string *)
let rec concat_xml xml =
	if xml = [] then ""
	else hd(xml) ^ concat_xml(tl(xml));;

(* Print document *)
let rec print_xml = function 
[] -> ()
| e::l -> print_string e ; print_xml l

(* Remove spaces from a string *)
let rec trim str =
	if str = "" then ""
	else let search_pos init p next =
	let rec search i =
	if p i then raise(Failure "empty")
	else match str.[i] with
	| ' ' | '\n' | '\r' | '\t' -> search (next i)
	| _ -> i in
	search init in
	let len = String.length str in
	try
	let left = search_pos 0 (fun i -> i >= len) (succ)
	and right = search_pos (len - 1) (fun i -> i < 0) (pred) in
    	String.sub str left (right - left + 1)   with   | Failure "empty" -> "" ;;

(* Write message to file *)
let rec print_file(xml_content,filename) =
	let oc = open_out(trim(filename ^ ".svg")) in
	fprintf oc "%s\n" xml_content;   
	close_out oc;;
