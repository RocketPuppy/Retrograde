{ bash, lib, file }:
let
  lines = builtins.filter (x: builtins.isString x && x != "") (
        builtins.split "\n" (builtins.readFile file));
  rows = builtins.tail lines;
  header = builtins.head lines;
  fileName = builtins.baseNameOf file;
  rowDrv = row:
    let
      name = builtins.hashString "md5" row;
      cardName = builtins.head (builtins.filter (x: x != null) (builtins.head (builtins.tail (builtins.split "^(\"[^\"]*\")|^([^,]+)" row))));
    in
    derivation {
      name = "retrograde-card-${name}-${fileName}";
      builder = "${bash}/bin/bash";
      system = builtins.currentSystem;
      args = [(builtins.toFile "card-builder" ''
        echo $header > $out
        echo $row >> $out
      '')];
      source = lib.strings.removeSuffix ".csv" fileName;
      inherit row header cardName;
    };
in
builtins.map rowDrv rows
