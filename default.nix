with (import ./nixpkgs.nix {});
rec {
  squib = callPackage ./squib {
    inherit (xorg) libpthreadstubs libXdmcp;
    ruby = ruby_2_6;
    rubyPackages = rubyPackages_2_6;
  };
  cards = callPackage ./cards {};
  deck-data = callPackage ./decks/files.nix { inherit cards; };
  decks = callPackage ./decks {
    inherit deck-data cards;
  };
  mk-cards = { doPrint, doImport, name, card-list, assets, upgrades, spacecraft}:
    callPackage ./renderer {
      inherit (xorg) libpthreadstubs libXdmcp;
      inherit squib doImport doPrint card-list assets upgrades spacecraft;
      ruby = ruby_2_6;
      rubyPackages = rubyPackages_2_6;
    };
  rendered = {
    cards = rec {
      import = builtins.mapAttrs (n: c: mk-cards { doPrint = false; doImport = true; name = c.name; card-list = c.card-list; assets = c.render-files; upgrades = c.render-files; spacecraft = c.render-files; }) cards.byName;
      print = builtins.mapAttrs (n: c: mk-cards { doPrint = true; doImport = false; name = c.name; card-list = c.card-list; assets = c.render-files; upgrades = c.render-files; spacecraft = c.render-files; }) cards.byName;
      all = builtins.attrValues import;
    };
    decks = rec {
      import = builtins.listToAttrs (builtins.map (d: { name = d.deck-name; value = mk-cards { doPrint = false; doImport = true; name = d.deck-name; card-list = d; assets = d.assets; upgrades = d.upgrades; spacecraft = d.spacecraft; }; }) decks);
      print = builtins.listToAttrs (builtins.map (d: { name = d.deck-name; value = mk-cards { doPrint = true; doImport = false; name = d.deck-name; card-list = d; assets = d.assets; upgrades = d.upgrades; spacecraft = d.spacecraft; }; }) decks);
      all = builtins.attrValues import;
    };
  };
  #rulebook = callPackage ./rulebook {
  #  cards = rendered.cards.all;
  #};
}
