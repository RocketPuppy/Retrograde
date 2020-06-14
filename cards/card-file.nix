{ callPackage, path }:
let
  lines = builtins.filter (x: builtins.isString x && x != "") (
        builtins.split "\n" (builtins.readFile path));
  header = builtins.head lines;
  rows = builtins.tail lines;
  file-name = builtins.baseNameOf path;
in
builtins.map (row: callPackage ./card.nix { inherit row header file-name; }) rows
