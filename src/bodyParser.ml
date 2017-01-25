(* body-parser / npm *)

open Express

module BodyParser =
  struct
    type bodyParser

    external json :
      unit
      -> Express.middlewareT
      = ""[@@bs.module "body-parser"]
  end