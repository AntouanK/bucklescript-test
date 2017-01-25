
open Logger
open Express
open BodyParser
open Date


let printNow logger =
  Date.now ()
  |> Date.newDate
  |> Date.toIsoString
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
  let testHandler (req:Request.t) (res:Response.t) (next:Next.t) =
    Response.json res [%bs.obj {root = 1}] ;
  in
  let counterUpHandler (req:Request.t) (res:Response.t) (next:Next.t) =
    let body = req##body in
    (* increase a field of the body that has a number *)
    Response.json res body ;
  in

  (* set a GET route at /text *)
  Express.get app "/test" testHandler ;

  (* set a POST route at /counterUp *)
  let counterUpRoute =
    Express.post app "/counterUp"
  in
  (* first use body-parser to parse the incoming request body *)
  counterUpRoute @@ BodyParser.json () ;
  (* then pass the final middleware to that route *)
  counterUpRoute counterUpHandler ;

  (* set the static server *)
  let staticOptions =
    let open Express in
    [%bs.obj
      { dotfiles = "ignore";
        etag = true;
        extensions = false;
        fallthrough = true;
        lastModified = true;
        maxAge = 0;
        redirect = false;
      }
    ]
  in
  let dirname =
    match Js.Undefined.to_opt [%bs.node __dirname] with
    | None -> "./"
    | Some x -> x
  in

  Express.use
    app
    @@ Express.static ~root:dirname ~options:staticOptions ;

  (* start the Express server *)
  Express.listen app ~port:serverPort ~callback:logSuccess ();
