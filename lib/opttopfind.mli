(* Copyright 1999 by Gerd Stolpmann
 * 
 * The package "findlib" is copyright by Gerd Stolpmann. 
 * 
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this document and the "findlib" software (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 * 
 * The Software is provided ``as is'', without warranty of any kind, express
 * or implied, including but not limited to the warranties of
 * merchantability, fitness for a particular purpose and noninfringement.
 * In no event shall Gerd Stolpmann be liable for any claim, damages or
 * other liability, whether in an action of contract, tort or otherwise,
 * arising from, out of or in connection with the Software or the use or
 * other dealings in the software.
 *
 *)

(** Load packages from toploops and scripts
 *
 * The [Topfind] module is part of the [findlib] package. The module
 * depends on the presence of a toploop. When building a toploop, it is
 * automatically linked in if "findlib" is linked in, e.g.
 * {[
 * ocamlfind ocamlmktop ...options... -package findlib -linkpkg 
 * ]}
 * 
 * When the platform supports DLLs, another possibility to get a toploop
 * with findlib directives is to load the file "topfind" (normally installed
 * in the standard library directory):
 * {[
 * $ ocaml
 *         Objective Caml version 3.04
 * # #use "topfind";;
 * Findlib has been successfully loaded. Additional directives:
 *   #require "package";;      to load a package
 *   #list;;                   to list the available packages
 *   #camlp4o;;                to load camlp4 (standard syntax)
 *   #camlp4r;;                to load camlp4 (revised syntax)
 *   Topfind.reset();;         to force that packages will be reloaded
 * ~ : unit = ()
 * # _
 * ]}
 *
 * This works even in scripts (but the startup message is suppressed in this
 * case).
 *
 * The module is not thread-safe; if used in a multi-threaded script, all
 * packgage loading must have happened before the first thread forks.
 *
 * The Topfind module contains some functions simplifying package loading
 * in scripts. Most important, there is a new directive [#require] for
 * the same purpose (see below).
 *
 * The [Topfind] module needs some initialization, in particular the 
 * [predicates] variable needs to be
 * set, and the packages already compiled into the toploop needs to be
 * declared by the [don't_load]
 * function. If the toploop has been built by [ocamlfind],
 * the necessary initialization is
 * automatically compiled in.
 *)

(** {1 Directives}
 *
 * This module also defines the following directives for the toploop:
 *
 * - [#require "<package>"]
 *   loads the package (and if necessary the prerequisites of the package)
 * - [#camlp4o]
 *   loads camlp4 and selects standard syntax
 * - [#camlp4r]
 *   loads camlp4 and selects revised syntax
 * - [#list]
 *   lists the available packages (calls external command "ocamlfind")
 * - [#thread]
 *   enables multi-threading if possible
 * - [#predicates "p1,p2,..."]
 *   adds these predicates
 *)

(** {1 Functions and variables} *)

val predicates : string list ref
  (** The list of predicates used for package loading *)

val add_predicates : string list -> unit
  (** Adds predicates to the list of predicates *)

val syntax : string -> unit
  (** Emulates the [-syntax] option *)

val standard_syntax : unit -> unit
  (** Adds predicates that select the standard syntax. Same as
   * [syntax "camlp4o"]
   *)

val revised_syntax : unit -> unit
  (** Adds predicates that select the revised syntax. Same as 
   * [syntax "camlp4r"] 
   *)

val don't_load : string list -> unit
  (** The packages named in pkglist are added to the list of packages which
   * are already loaded.
   *)

val don't_load_deeply : string list -> unit
  (** The packages named in pkglist and all direct and indirect ancestors
   * are added to the list of packages which are already loaded.
   *)

val load : string list -> unit
  (** The packages from the passed package list are loaded, from left to
   * right, but packages that have already been loaded are left out.
   *)

val load_deeply : string list -> unit
  (** The packages from the passed package list and all direct or indirect 
   * ancestors are loaded in topological order. Packages that have already
   * been loaded are left out.
   *)

val reset : unit -> unit
  (** All entries in the list of loaded packages that have been added by
   * [load] or [load_deeply] functions are removed from this list. This
   * means that if you execute the same [load] or [load_deeply] functions
   * again, the packages will be reloaded.
   *)

val announce : unit -> unit
  (** Output the startup message *)

val log : (string -> unit) ref
  (** Function used to log messages from this module. *)
