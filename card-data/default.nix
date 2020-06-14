{ lib, bash, coreutils }:
let
  src = ./.;
  headersFn = import ./headers.nix;
  cardFn = import ./card.nix;
  files = builtins.filter (lib.strings.hasSuffix ".csv") (builtins.attrNames (builtins.readDir src));
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
  fileDrvs = builtins.map fileToDrv files;
  cardDrvs = lib.lists.concatMap (f: cardFn { file = f; inherit bash lib; }) fileDrvs;
in
fileDrvs ++ cardDrvs
