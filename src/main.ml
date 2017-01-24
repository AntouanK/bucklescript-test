
type t

external consologger : unit -> t = "consologger" [@@bs.module][@@bs.new]
external text : t -> string -> unit = "text" [@@bs.send]
external green : t -> string -> unit = "green" [@@bs.send]
external print : t -> unit = "print" [@@bs.send]

let () =
  let logger = consologger () in
  text logger "[test]" ;
  green logger "Success" ;
  print logger ;
