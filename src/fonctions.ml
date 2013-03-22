(* Un module est défini par un n-uplet
 - son nom : string
 - la liste de ses entrées : string list
 - la liste de ses sorties : string list
 - the list of disciplines *)

type t_module = {
  nom     : string; 
  entrees : string list;
  sorties : string list};;

type t_modules = string list * string list * t_module list;;

(*****************************)
(* Opérations sur les listes *)
(*****************************)

(* Ajoute un élément à la liste s'il n'y est pas déjà *)
let rec list_add e l = match (e,l) with
    (a,[]) -> [a]
  | (a,b) when a = (List.hd b) -> b
  | (a,hd::tl) -> hd::(list_add a tl);;

(* Efface la première occurrence de e dans l *)
let rec list_del e l = match (e,l) with
    (_,[]) -> []
  | (a,hd::tl) when a = hd -> tl
  | (a,hd::tl) -> hd::(list_del a tl);;

(* Efface toutes les occurrences de e dans l *)
let rec list_del_all e l = match (e,l) with
    (_,[]) -> []
  | (a,hd::tl) when a = hd -> list_del_all e tl
  | (a,hd::tl) -> hd::(list_del_all a tl);;

(* Renvoie l1 privée de tous les élements de l2 *)
let rec list_sub l1 l2 = match (l1,l2) with
    (a,[]) -> a
  | (a,hd::tl) -> list_sub (list_del hd a) tl;;

(* Ajoute les élémements de l1 à l2*)
let rec list_merge l1 l2 = match (l1,l2) with
    ([],a) -> a
  | (hd::tl,a) -> list_merge tl (list_add hd a);;

(************************)
(* Affichage des module *)
(************************)

let rec string_of_list = function
    [] -> ""
  | hd::tl -> hd^" "^(string_of_list tl);;

let print_module m =
  print_endline (m.nom^" :");
  print_endline ("\t"^"Entrées : "^(string_of_list m.entrees));
  print_endline ("\t"^"Sorties : "^(string_of_list m.sorties));;

let print_modules (_,_,m) =
  List.iter print_module m;;

(***********************)
(* Affichage du graphe *)
(***********************)

let print_es es =
  let ligne l = print_endline ("\t"^l^" [shape=circle];") in
  List.iter ligne es;;

let print_noms n =
  let ligne l = print_endline ("\t"^l^" [shape=box];") in
  List.iter ligne n;;

let print_module_g m =
  let entree e = print_endline ("\t"^e^" -> "^m.nom) in
  let sortie s = print_endline ("\t"^m.nom^" -> "^s) in
  List.iter entree m.entrees;
  List.iter sortie m.sorties;;

let print_modules_g m =
  List.iter print_module_g m;;

let print_graphe (es,noms,m) =
  print_endline "digraph G {";
  print_es es;
  print_noms noms;
  print_modules_g m;
  print_endline "}";;
