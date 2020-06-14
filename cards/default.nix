{ lib, callPackage }:
let
  src = ./.;
  files = builtins.filter (lib.strings.hasSuffix ".csv") (builtins.attrNames (builtins.readDir src));
  types = builtins.map (lib.strings.removeSuffix ".csv") files;
  paths = builtins.map (f: src + ("/" + f)) files;
  cards = lib.lists.concatMap (path: callPackage ./card-file.nix { inherit path; }) paths;
  getType = t: builtins.filter (d: d.type == t) cards;
in
{
  all = cards;
  byName = builtins.listToAttrs (
    builtins.map (d: { name = d.card-name; value = d; }) cards
  );
  byType = builtins.listToAttrs (
    builtins.map (t: { name = t; value = getType t; }) types
  );
}
