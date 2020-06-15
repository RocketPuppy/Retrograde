{ bash, gnugrep, coreutils, card-data, deck-data }:
let
  src = ./.;
  mk-card-data = import ./type-deck.nix;
  mk-deck = import ./deck.nix;
  card-data-decks = builtins.map (type: mk-card-data { inherit bash coreutils gnugrep; name = type; cards = builtins.getAttr type card-data.byType; }) (builtins.attrNames card-data.byType);
  decks = builtins.map (d: mk-deck { inherit bash coreutils; name = d.name; deck = d; card-set = card-data.byName; }) deck-data;
in
card-data-decks ++ decks
