{ bash, coreutils, name, deck, card-set, data-file-types }:
let
  src = ./.;
  card-names = builtins.tail (
    builtins.filter (x: builtins.isString x && x != "") (
      builtins.split "\n" (builtins.readFile deck)));
  cards = builtins.map (name:
    builtins.getAttr name card-set
  ) card-names;
  mk-data-file = import ./build-data-file.nix;
  type-files = builtins.listToAttrs (builtins.map (
    type: {
      name = type;
      value = mk-data-file {
        deck-name = name;
        inherit cards type;
        inherit bash coreutils;
      };
    }) data-file-types);
in
derivation ({
  name = "retrograde-decks-${name}";
  deck-name = name;
  deckname = name;
  system = builtins.currentSystem;
  builder = "${bash}/bin/bash";
  args = [(builtins.toFile "file-builder" ''
    export PATH=$coreutils/bin
    # TODO: I should be able to just copy the file to
    # $out, but something in the cards derivation seems
    # to be sourcing it.
    mkdir $out
    cp $deck $out/$deckname.csv
  '')];
  inherit deck coreutils;
} // type-files)
