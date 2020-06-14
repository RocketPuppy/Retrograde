{ lib, bash, coreutils, file }:
let
  src = ./.;
  # derivation to pull out header
  # derivation to pull out lines
  # derivation to smash header + each line
  # derivation to rebuild original CSV file
  headers = builtins.readFile :
  fileToDrv = file:
    let
      storeFile = builtins.toFile file (builtins.readFile (src + ("/" + file)));
    in derivation {
      name = file;
      system = builtins.currentSystem;
      builder = "${bash}/bin/bash";
      args = [(builtins.toFile "file-builder" ''
        $coreutils/bin/cp $storeFile $out
      '')];
      inherit storeFile coreutils;
    };
in
builtins.map fileToDrv files

