with (import <nixpkgs> {});

let
  squib = callPackage ./squib {
    inherit (xorg) libpthreadstubs libXdmcp;
    ruby = ruby_2_6;
    rubyPackages = rubyPackages_2_6;
  };
  # DONE: can there be a single derivation per card? I've already got them per file.
  # Build each card as its own derivation. Also group them by type and name. Also output derivations for the full type data files
  card-data = callPackage ./card-data {};
  # DONE: can each deck be dependent on just the cards it references?
  # Build the main deck files and put them in the store so they can be referenced
  deck-data = callPackage ./decks/files.nix {};
  # Build deck files for the main decks, and build type decks for easy rendering
  decks = callPackage ./decks {
    inherit deck-data card-data;
  };
  # TODO: decks and card-data are parameterized per file now
  # need to parameterize cards per file and per mode
  # Render each deck, parameterized by decks and transitively by card data
  cards = builtins.map (deck:
    callPackage ./cards {
      inherit (xorg) libpthreadstubs libXdmcp;
      inherit card-data squib deck;
      ruby = ruby_2_6;
      rubyPackages = rubyPackages_2_6;
    }) decks;
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
