(lang dune 2.8)
(name opttopfind)

(generate_opam_files true)

(license MIT)
(source (github NathanReb/opttopfind))
(maintainers "Nathan Rebours <nathan.p.rebours@gmail.com")
(authors "Nathan Rebours <nathan.p.rebours@gmail.com")

(package
 (name opttopfind)
 (depends
   compiler-libs-opttoplevel
   ocamlfind)
 (synopsis "Topfind port to native toplevel"))
