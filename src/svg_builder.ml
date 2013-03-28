open List;;

type xml = string list list;;

(* Initialize xml doc *)
let rec start_xml() = 
	let node = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"::[]
	and document = [] in
		node::document;;

(* Build the beginning of the root node of the svg document *)
let rec begin_root document w h =
	let root = "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\""^w^"\" height=\""^h^"\">" in
		(root::[])::document;;
		
(* Build the end of the root of the svg document *)
let rec end_root document =
	("</svg>"::[])::document;;

(* Add node to document *)
let rec add_node document node =
	(node::[])::document;;
		
(* Add title node to document *)
let rec add_title document title =
	let node = "  <title>"^title^"</title>" in
		add_node document node;;		

(* Print the xml document 
let rec print_xml document =
	if document = [] then print_endline "Doc vide"
	else if tl(document) = [] then print_xml hd(document)
	else if 
*)
(*
let rec print_list2 liste =
	if liste = [] then ()
	else print_endline(hd(liste));
		print_list2(tl(liste));;

(* Print the xml document *)
let rec print_list liste =
	if liste = [] then ()
	else print_list2( hd(liste));
		 print_list(tl(liste));;
*)


(* Print document *)
let rec print_list l =
	if l = [] then ()
	else if tl(l) = [] then print_endline(hd(l))
	else
		print_endline(hd(l));
		print_list(tl(l));;
 
let rec print_list_of_list ll =
	if ll = [] then ()
	else if tl(ll) = [] then print_list(hd(ll))
	else
		print_list(hd(ll));
		print_list_of_list(tl(ll));;
