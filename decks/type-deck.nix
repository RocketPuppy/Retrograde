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
    export CARDS=($cards)
    echo "name" > $out
    for f in $cards; do
      cat $f | tail -n +2 | grep -E -o "^\"[^\"]*\"|^[^,]+" >> $out
    done
  '')];
  inherit cards coreutils gnugrep;
}
