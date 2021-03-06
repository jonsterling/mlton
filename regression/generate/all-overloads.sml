structure List =
   struct
      fun foreach (l, f) = List.app f l
      fun map (l, f) = List.map f l
      val tabulate = List.tabulate
   end

val int =
   List.map (["Int", "IntInf", "LargeInt", "FixedInt", "Position"]
             @ List.map (List.tabulate (31, fn i => i + 2) @ [64],
                         fn i => concat ["Int", Int.toString i]),
             fn s => concat [s, ".int"])

val real =
   List.map (["Real", "Real32", "Real64", "LargeReal"],
             fn s => concat [s, ".real"])

val word =
   List.map (["Word", "LargeWord", "SysWord"]
             @ List.map (List.tabulate (31, fn i => i + 2) @ [64],
                         fn i => concat ["Word", Int.toString i]),
             fn s => concat [s, ".word"])

val text = ["Char.char", "String.string"]

val num = int @ word @ real
val numtext = num @ text
val realint = int @ real
val wordint = int @ word

datatype ty = Binary | Compare | Unary
val binary = Binary
val compare = Compare
val unary = Unary

val () = print "(* This file is automatically generated.  Do not edit. *)\n"
   
val () =
   List.foreach
   ([(2, "~", unary, num),
    (2, "+", binary, num),
    (2, "-", binary, num),
    (2, "*", binary, num),
    (4, "/", binary, real),
    (3, "div", binary, wordint),
    (3, "mod", binary, wordint),
    (3, "abs", unary, realint),
    (1, "<", compare, numtext),
    (1, "<=", compare, numtext),
    (1, ">", compare, numtext),
    (1, ">=", compare, numtext)],
    fn (prec, f, ty, class) =>
    List.foreach
    (class, fn c =>
     print (concat ["fun f (x: ", c, ") = ",
                    case ty of
                      Binary => concat ["x ", f,  " x"]
                    | Compare => concat ["x ", f, " x"]
                    | Unary => concat [f, " x"],
                    "\n"])))
