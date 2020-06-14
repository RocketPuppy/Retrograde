{ bash, gnugrep, card-data }:
let
  src = ./.;
in
derivation {
  name = "retrograde-decks-${card-data.name}";
  system = builtins.currentSystem;
  builder = "${bash}/bin/bash";
  args = [(builtins.toFile "file-builder" ''
    $gnugrep/bin/grep -E -o "^(\"[^\"]*\")|^([^,]+)" $carddata > $out
  '')];
  carddata = card-data;
  inherit gnugrep;
}
