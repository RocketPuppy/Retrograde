{ bash, gnugrep, coreutils, name, cards }:
let
  src = ./.;
in
derivation {
  name = "retrograde-decks-${name}";
  system = builtins.currentSystem;
  builder = "${bash}/bin/bash";
  args = [(builtins.toFile "file-builder" ''
    export PATH=$coreutils/bin:$gnugrep/bin
    echo "name" > $out
    for f in $cards; do
      cat $f/out.csv | tail -n +2 | grep -E -o "^\"[^\"]*\"|^[^,]+" >> $out
    done
  '')];
  cards = builtins.map (c: c.card-list) cards;
  inherit coreutils gnugrep;
}
