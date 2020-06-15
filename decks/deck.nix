{ bash, coreutils, name, deck, card-set }:
let
  src = ./.;
  card-names = builtins.tail (
    builtins.filter (x: builtins.isString x && x != "") (
      builtins.split "\n" (builtins.readFile deck)));
  cards = builtins.map (name:
    builtins.getAttr name card-set
  ) card-names;
in
derivation {
  name = "retrograde-decks-${name}";
  system = builtins.currentSystem;
  builder = "${bash}/bin/bash";
  args = [(builtins.toFile "file-builder" ''
    export PATH=$coreutils/bin
    cp $deck $out
  '')];
  inherit deck cards coreutils;
}

