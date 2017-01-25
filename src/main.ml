
open Logger
open Express

external dirname : string = "__dirname" [@@bs.val]

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

let serverPort = 3210;;

(* main *)
let () =
  let logger = Logger.makeNew () in
  let logSuccess () =
    Logger.green logger "Express server listening"
    |> printNow ;
  in
  let app = Express.express () in

  Logger.text logger @@ "[test] " ^ dirname
  |> printNow ;

  let testHandler (req:Request.t) (res:Response.t) (next:Next.t) =
    Response.json res [%bs.obj {root = 1}] ;
  in

  (* set a GET route at /text *)
  Express.get
    app
    "/test"
    testHandler ;


  (* set the static server *)
  Express.use
    app
    @@ Express.static ~root:dirname ;

  (* start the Express server *)
  Express.listen
    app
    ~port:serverPort
    ~callback:logSuccess
    ();
