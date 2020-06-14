{ bash, coreutils, file }:
derivation {
  name = "headers-${file.name}";
  system = builtins.currentSystem;
  builder = "${bash}/bin/bash";
  args = [(builtins.toFile "file-builder" ''
    $coreutils/bin/head -n 1 $file > $out
  '')];
  inherit file coreutils;
}
