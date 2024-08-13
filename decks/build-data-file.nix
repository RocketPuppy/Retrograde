{ coreutils, bash, deck-name, cards, type }:
let
  cards-by-type = builtins.filter (card: card.type == type) cards;
in
derivation {
  name = "retrograde-decks-${type}-${deck-name}";
  system = builtins.currentSystem;
  builder = "${bash}/bin/bash";
  args = [(builtins.toFile "file-builder" ''
    export PATH=$coreutils/bin
    CARDS=($cards)
    mkdir $out
    cat ''${CARDS[0]} | head -n1 > $out/$type.csv
    touch card-data.csv
    for f in $cards; do
      cat "$f" | tail -n +2 >> card-data.csv
    done
    sort card-data.csv | uniq >> $out/$type.csv
  '')];
  cards = builtins.map (c: c.card-file) cards-by-type;

  inherit coreutils type;
}
