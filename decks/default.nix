{ bash, gnugrep, coreutils, cards, deck-data }:
let
  src = ./.;
  mk-type-deck = import ./type-deck.nix;
  mk-deck = import ./deck.nix;
  type-decks = builtins.map (
    type: mk-type-deck {
      name = type;
      cards = builtins.getAttr type cards.byType;
      inherit bash coreutils gnugrep;
    }) (builtins.attrNames cards.byType);
in
builtins.map (
  d: mk-deck {
    name = d.name;
    deck = d;
    card-set = cards.byName;
    data-file-types = builtins.attrNames cards.byType;
    inherit bash coreutils;
  }) (deck-data ++ type-decks)
