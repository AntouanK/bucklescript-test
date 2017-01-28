(* body-parser / npm *)

open Express

module BodyParser =
  struct
    type bodyParser

    type requestContentType =
      < _type : string
      >
      Js.t;;

    external json :
      unit
      -> Express.middlewareT
      = ""[@@bs.module "body-parser"]

    external raw :
      unit
      -> Express.middlewareT
      = ""[@@bs.module "body-parser"]

    external text :
      unit
      -> Express.middlewareT
      = ""[@@bs.module "body-parser"]

    let jsonText :
      unit
      -> Express.middlewareT
      = [%bs.raw{| () => require('body-parser').text({ type: 'application/json' }) |}]
  end