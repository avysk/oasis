
(** Executable schema and generator
    @author Sylvain Le Gall
  *)

open OASISTypes;;
open OASISSchema;;
open OASISValueParser;;

let schema, generator =
  let schm =
    schema ()
  in
  let main_is =
    new_field schm "mainis" 
      (fun ctxt vl ->
         str_regexp
           (Str.regexp ".*\\.ml$")
           ".ml file"
           ctxt
           (file_exists ctxt vl))
  in
  let buildable =
    new_field schm "buildable"
      ~default:true
      boolean
  in
    schm,
    (fun wrtr -> 
       {
         exec_buildable = buildable wrtr;
         exec_main_is   = main_is wrtr;
         exec_extra     = extra wrtr;
       })
;;

