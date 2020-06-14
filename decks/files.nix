{ lib, bash, coreutils }:
let
  src = ./.;
  files = builtins.filter (lib.strings.hasSuffix ".csv") (builtins.attrNames (builtins.readDir src));
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
builtins.map fileToDrv files
