(* Promise *)
module Promise =
  struct
    type 'a promiseT
    type errorT
    external thenDo : 'a promiseT -> ('a -> 'b) -> 'b promiseT = "then" [@@bs.send ]
    external catchError : 'a promiseT -> (errorT -> unit) -> 'a promiseT = "catch"[@@bs.send ]
  end

(* date *)
type date

external newDate : string -> date = "Date" [@@bs.new]
external now : unit -> string = "Date.now" [@@bs.val]
external toIsoString : date -> string = "toISOString" [@@bs.send]


(* main *)
let () =
  let logger = Logger.makeNew () in
  Logger.text logger "[test]" ;
  Logger.green logger "Success" ;

  now ()
  |> newDate
  |> toIsoString
  |> Logger.blue logger
  |> Logger.print ;