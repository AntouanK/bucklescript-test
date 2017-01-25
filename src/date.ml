(* date *)

module Date =
  struct
    type date

    external newDate : string -> date = "Date" [@@bs.new]
    external now : unit -> string = "Date.now" [@@bs.val]
    external toIsoString : date -> string = "toISOString" [@@bs.send]
  end
