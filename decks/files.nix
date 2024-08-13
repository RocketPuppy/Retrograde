{ lib, bash, coreutils, gnugrep, cards }:
let
  src = ./.;
  files = builtins.filter (lib.strings.hasSuffix ".csv") (builtins.attrNames (builtins.readDir src));
  mk-type-deck = import ./type-deck.nix;
  type-files = builtins.map (
    type: mk-type-deck {
      name = type;
      cards = builtins.getAttr type cards.byType;
      inherit bash coreutils gnugrep;
    }) (builtins.attrNames cards.byType);
  fileToDrv = file:
    let
      storeFile = builtins.toFile file (builtins.readFile (src + ("/" + file)));
    in derivation {
      name = "retrograde-file-${file}";
      system = builtins.currentSystem;
      builder = "${bash}/bin/bash";
      args = [(builtins.toFile "file-builder" ''
        $coreutils/bin/cp $storeFile $out
      '')];
      inherit storeFile coreutils;
    };
in
(builtins.map fileToDrv files) ++ type-files
