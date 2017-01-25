
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

(* main *)
let () =
  let logger = Logger.makeNew () in
  Logger.text logger "[test]" ;
  Logger.green logger "Success with modules" ;

  let app = Express.express () in

  now ()
  |> newDate
  |> toIsoString
  |> Logger.blue logger
  |> Logger.print ;

  Express.listen app ~port:3210 () ;

(*
var express = require('express')
var app = express()

app.get('/', function (req, res) {
  res.send('Hello World!')
})

app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
})*)