(* problem 1 *)
val only_capitals = List.filter (fn s => Char.isUpper (String.sub(s,0)))

(* problem 2 *)
val longest_string1 = 
  List.foldl (fn (s,sofar) => if String.size s > String.size sofar
				            then s
				            else sofar) 
	               ""

(* problem 3 *)
val longest_string2 = 
  List.foldl (fn (s,sofar) => if String.size s >= String.size sofar
				            then s
				            else sofar) 
	               ""

(* problem 4 *)
fun longest_string_helper f = 
  List.foldl (fn (s,sofar) => if f(String.size s,String.size sofar)
				            then s
				            else sofar) 
	               ""
val longest_string3 = longest_string_helper (fn (x,y) => x > y) 
val longest_string4 = longest_string_helper (fn (x,y) => x >= y)

(*
	More elegant, alternative solutions
	val longest_string3 = longest_string_helper op> 
	val longest_string4 = longest_string_helper op>= 
*)

(* problem 5 *)
val longest_capitalized = longest_string1 o only_capitals

(* problem 6 *)
val rev_string = String.implode o rev o String.explode

(* problem 7 *)
fun first_answer f xs =
  case xs of
    [] => raise NoAnswer
   | x::xs' => case f x of NONE => first_answer f xs'
			           | SOME y => y

(* problem 8 *)
fun all_answers f xs =
  let fun loop (acc,xs) =
    case xs of
		    [] => SOME acc
	    | x::xs' => case f x of 
             NONE => NONE
       			  | SOME y => loop((y @ acc), xs')
  in loop ([],xs) end

(* problem 9 *)
val count_wildcards = g (fn () => 1) (fn _ => 0)
val count_wild_and_variable_lengths = g (fn () => 1) String.size
fun count_some_var (x,p) = g (fn () => 0) (fn s => if s = x andalso p(s) then 1 else 0)

(* problem 10 *)
fun check_pat pat =
  let fun get_vars pat =
     case pat of
       Variable s => [s]
      | TupleP ps => List.foldl (fn (p,vs) => get_vars p @ vs) [] ps
      | ConstructorP(_,p) => get_vars p
      | _ => []
    fun unique xs =
     case xs of
       [] => true
      | x::xs' => (not (List.exists (fn y => y=x) xs'))
            andalso unique xs'
  in
    unique (get_vars pat)
  end

(* problem 11 *)
fun match (valu,pat) =
  case (valu,pat) of
	   (_,Wildcard)  => SOME []
   | (_,Variable(s)) => SOME [(s,valu)]
