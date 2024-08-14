{ bash, gnugrep, coreutils, cards, deck-data }:
let
  src = ./.;
  mk-deck = import ./deck.nix;
in
builtins.map (
  d: mk-deck {
    name = d.name;
    deck = d;
    card-set = cards.byName;
    data-file-types = builtins.attrNames cards.byType;
    inherit bash coreutils;
  }) deck-data
