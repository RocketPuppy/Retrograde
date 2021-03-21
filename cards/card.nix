{ lib, bash, coreutils, header, row, file-name }:
let
  name = builtins.hashString "md5" row;
  card-name = builtins.replaceStrings ["\""] [""] (
    builtins.head (
      builtins.filter (x: x != null) (
        builtins.head (
          builtins.tail (
            builtins.split "^(\"[^\"]*\")|^([^,]+)" row)))));
  type = lib.strings.removeSuffix ".csv" file-name;
  card-file = derivation {
    name = "retrograde-card-${name}-${file-name}";
    builder = "${bash}/bin/bash";
    system = builtins.currentSystem;
    args = [(builtins.toFile "card-builder" ''
      echo $header > $out
      echo $row >> $out
    '')];
    inherit row header;
  };
  card-list = derivation {
    name = "retrograde-card-list-${name}-${file-name}";
    builder = "${bash}/bin/bash";
    system = builtins.currentSystem;
    args = [(builtins.toFile "card-list-builder" ''
      export PATH=$coreutils/bin:$PATH
      mkdir $out
      echo "name" > "$out/$cardname.csv"
      echo \"$cardname\" >> "$out/$cardname.csv"
    '')];
    cardname = card-name;
    inherit coreutils;
  };
  render-files = derivation {
    name = "retrograde-card-render-files-${type}-${name}-${file-name}";
    builder = "${bash}/bin/bash";
    system = builtins.currentSystem;
    args = [(builtins.toFile "card-render-files-builder" ''
      export PATH=$coreutils/bin:$PATH
      mkdir $out
      cp $cardfile $out/$type.csv
    '')];
    cardfile = card-file;
    inherit type coreutils;
  };
in
# { card-list : file containing a "deck" for input into the renderer
# , render-files : directory containing a data-file for input into the renderer
# , card-name : the name of the card, for reference
# , type : the type of the card (e.g. assets)
# , card-file : a csv file with the card in it
# }
{
  inherit card-list render-files card-name type card-file;
}
