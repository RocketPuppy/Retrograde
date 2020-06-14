{ bash, gnugrep, card-data, deck-data }:
let
  src = ./.;
  mk-card-data = import ./card-data.nix;
  card-data-decks = builtins.map (d: mk-card-data { card-data = d; inherit bash gnugrep; }) card-data;
in
card-data-decks ++ deck-data
