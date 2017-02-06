Control.Print.printDepth := 100;
Control.Print.printLength := 100;

(* Problem 1 *)

fun merge [] L1 = L1
|   merge L2 [] = L2
|   merge (x::xs) (y::ys) =
if x<y then x::merge xs (y::ys) else y::merge (x::xs) ys

(* Problem 2 *)

fun split [] = ([], [])
|	split [x] = ([x], [])
| 	split (x1::x2::xs) = 
		
		let
			val (xs1, xs2) = split xs
		in
			((x1::xs1), (x2::xs2))
		end

(* Problem 3 *)

fun mergeSort [] = []
| 	mergeSort [x] = [x]
|	mergeSort L =
		let
			val (this, that) = split L
		in
			merge (mergeSort this) (mergeSort that)
		end

(* Problem 4 *)

fun sort (op <) [] = []
|	sort (op <) [x] = [x]
|	sort (op <) L =
		let
			fun merge [] L1 = L1
			|   merge L2 [] = L2
			|   merge (x::xs) (y::ys) =
				if x<y then x::merge xs (y::ys) else y::merge (x::xs) ys

			fun split [] = ([], [])
			|	split [x] = ([x], [])
			| 	split (x1::x2::xs) = 
		
				let
					val (xs1, xs2) = split xs
				in
					((x1::xs1), (x2::xs2))
				end


			val (this, that) = split L
		in
			merge (sort (op <) this) (sort (op <) that)
		end

(* Problem 5 *)

datatype 'a tree = empty | leaf of 'a | node of 'a * 'a tree * 'a tree

(* Problem 6 *)

fun labels (empty) = []
|	labels (leaf x) = [x]
|	labels (node (a, b, c)) = labels b @ (a :: labels c)

(* Problem 7 *)

infix ==
fun replace (op ==) x y (empty) = empty
|	replace (op ==) x y (leaf name) = if name==x then (leaf y) else (leaf name)
| 	replace (op ==) x y (node (var1, var2, var3)) = 
	let
		val this = if var1==x then y else var1 
		val left = replace (op ==) x y var2
		val	right = replace (op ==) x y var3

		in
			node (this, left, right)
		end	

(* Problem 8 *)

fun replaceEmpty y (empty) = y
| 	replaceEmpty y (leaf name) = (leaf name)
|	replaceEmpty y (node (var1, var2, var3)) =
		let 
			val left = replaceEmpty y var2
			val right = replaceEmpty y var3

			in
				node (var1, left, right)
			end

(* Problem 9 *)

fun mapTree f (empty) = f empty
|	mapTree f (leaf name) = f (leaf name)
|	mapTree f (node (var1, var2, var3)) = f (node(var1, (mapTree f var2), (mapTree f var3)))

(* increment function included for testing purposes *)

fun increment empty = leaf 0
| increment (leaf a) = leaf (a+1)
| increment (node (a, L, R)) = node (a+1, L, R)
	
(* Problem 10 *)

fun sortTree (op <) T = mapTree (fn (node (var1, var2, var3)) => node((sort (op <) var1), var2, var3) | (leaf var1) => (leaf (sort (op <) var1))| empty => empty) T

