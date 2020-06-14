with (import <nixpkgs> {});

let
  squib = callPackage ./squib {
    inherit (xorg) libpthreadstubs libXdmcp;
    ruby = ruby_2_6;
    rubyPackages = rubyPackages_2_6;
  };
  # DONE: can there be a single derivation per card? I've already got them per file.
  card-data = callPackage ./card-data {};
  # TODO: can each deck be dependent on just the cards it references?
  deck-data = callPackage ./decks/files.nix {};
  decks = callPackage ./decks {
    inherit card-data deck-data;
  };
  # TODO: decks and card-data are parameterized per file now
  # need to parameterize cards per file and per mode
  cards = callPackage ./cards {
    inherit (xorg) libpthreadstubs libXdmcp;
    inherit card-data squib decks;
    ruby = ruby_2_6;
    rubyPackages = rubyPackages_2_6;
  };
  # then finally package the whole thing up so the rulebook only has dependencies on the cards it needs
  rulebook = callPackage ./rulebook {
    inherit cards;
  };
  all = stdenvNoCC.mkDerivation {
    name = "retrograde-all";
    src = ./.;
    buildInputs = [squib card-data decks cards rulebook];
    installPhase = ''
      mkdir $out;
      ln -s $cards $out/cards
      ln -s $rulebook $out/rulebook
    '';
    inherit cards rulebook decks card-data squib;
    phases = ["installPhase"];
  };
in
all
