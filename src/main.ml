
open Logger
open Express

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

let printNow logger =
  now ()
  |> newDate
  |> toIsoString
  |> Logger.blue logger
  |> Logger.print ;;


(* main *)
let () =
  let logger = Logger.makeNew () in
  let logSuccess () =
    Logger.green logger "Express server listening"
    |> printNow ;
  in
  let app = Express.express () in

  Logger.text logger "[test]"
  |> printNow ;

  let testHandler (req:Request.t) (res:Response.t) (next:Next.t) =
    Response.json res [%bs.obj {root = 1}] ;
  in

  Express.get
    app
    "/test"
    testHandler ;

  Express.listen
    app
    ~port:3210
    ~callback:logSuccess
    ();
