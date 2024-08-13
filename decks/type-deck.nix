{ bash, gnugrep, coreutils, name, cards }:
let
  src = ./.;
in
derivation {
  name = "retrograde-decks-${name}";
  system = builtins.currentSystem;
  deck-name = name;
  builder = "${bash}/bin/bash";
  args = [(builtins.toFile "file-builder" ''
    export PATH=$coreutils/bin:$gnugrep/bin
    echo "name" > $out
    for f in $cards; do
      for e in $f/*.csv; do
        cat "$e" | tail -n +2 | grep -E -o "^\"[^\"]*\"|^[^,]+" >> $out
      done
    done
  '')];
  cards = builtins.map (c: c.card-list) cards;
  inherit coreutils gnugrep;
}
