{ lib, bash, coreutils }:
let
  src = ./.;
  types = ["assets" "upgrades" "spacecraft" ];
  cardFn = import ./card.nix;
  files = builtins.filter (lib.strings.hasSuffix ".csv") (builtins.attrNames (builtins.readDir src));
  files' = builtins.map (f: src + ("/" + f)) files;
  cardDrvs = lib.lists.concatMap (f: cardFn { file = f; inherit bash lib; }) files';
  getType = t: builtins.filter (d: d.source == t) cardDrvs;
in
{
  cards = cardDrvs;
  byName = builtins.listToAttrs (
    builtins.map (d: { name = d.cardName; value = d; }) cardDrvs
  );
  byType = builtins.listToAttrs (
    builtins.map (t: { name = t; value = getType t; }) types
  );
}
