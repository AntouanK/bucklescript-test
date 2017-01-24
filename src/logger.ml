(* consologger *)
type logger

external makeNew : unit -> logger = "consologger" [@@bs.module][@@bs.new]
external text : logger -> string -> logger = "text" [@@bs.send]
external green : logger -> string -> logger = "green" [@@bs.send]
external blue : logger -> string -> logger = "blue" [@@bs.send]
external print : logger -> unit = "print" [@@bs.send]