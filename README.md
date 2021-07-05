# opttopfind

`opttopfind` is a port of the `topfind` library, shipped with
[`ocamlfind`](https://github.com/ocaml/ocamlfind), compatible with the native toplevel.

It depends on [`compiler-libs-opttoplevel`](https://github.com/NathanReb/compiler-libs-opttoplevel)
and on a specific fork of OCaml 4.11, available
[here](https://github.com/NathanReb/ocaml/tree/jit-hook-411).

This package is a temporary port and the aim is to integrate this work into upstream ocamlfind
once the unification of the native and bytecode toplevel as a simple patch.

It was initally created for a prototyping a version of [MDX](https://github.com/realworldocaml/mdx)
using [ocaml-jit](https://github.com/NathanReb/ocaml-jit) but if you wish to play around with the
native toplevel and still benefit from `#require` directives you can give it a try!

To use the above mentionned compiler fork in a fresh local switch, run the following command:
```
opam compiler create --switch=. NathanReb:jit-hook-411
```

To use this, in addition to pinning this repo, you'll likely need to pin
`compiler-libs-opttoplevel`:
```
opam pin add compiler-libs-opttoplevel.0.1.0 git+https://github.com/NathanReb/compiler-libs-opttoplevel.git#0.1.0
opam pin opttopfind.dev git+https://github.com/NathanReb/opttopfind.git
```

You can also add the following `pin-depends` field to your opam file:
```
pin-depends: [
  [
    "compiler-libs-opttoplevel.0.1.0"
    "git+https://github.com/NathanReb/compiler-libs-opttoplevel.git#0.1.0"
  ]
  [
    "opttopfind.dev"
    "git+https://github.com/NathanReb/opttopfind.git"
  ]
]
```
