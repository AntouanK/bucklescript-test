(* express *)

module Next = struct type t end
module Request = struct type t end
module Response =
  struct
    type t

    external sendFile : t -> string -> 'a -> unit = ""[@@bs.send ]
    external json : t -> 'a -> unit = ""[@@bs.send ]
  end

module Express =
  struct
    type expressApp
    type middlewareT = Request.t -> Response.t -> Next.t -> ((unit)[@bs ])

    external express : unit -> expressApp = ""[@@bs.module ]
    external use : expressApp -> middlewareT -> unit = ""[@@bs.send ]
    external static : path:string -> middlewareT = ""[@@bs.module "express"]
    external get : expressApp -> string -> ('a -> Response.t -> ((unit)[@bs ])) -> unit = "" [@@bs.send ]
    external listen :
      expressApp
      -> ?port:int
      -> ?hostname:string
      -> ?callback:(unit -> unit)
      -> unit -> unit = ""[@@bs.send ]
  end
