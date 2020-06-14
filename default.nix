with (import <nixpkgs> {});

let
  squib = callPackage ./squib {
    inherit (xorg) libpthreadstubs libXdmcp;
    ruby = ruby_2_6;
    rubyPackages = rubyPackages_2_6;
  };
  card-data = callPackage ./card-data {};
  decks = callPackage ./decks {
    inherit card-data;
  };
  cards = callPackage ./cards {
    inherit (xorg) libpthreadstubs libXdmcp;
    inherit card-data squib decks;
    ruby = ruby_2_6;
    rubyPackages = rubyPackages_2_6;
  };
  all = stdenvNoCC.mkDerivation {
    name = "retrograde-all";
    src = ./.;
    buildInputs = [squib card-data decks cards];
    installPhase = ''
      mkdir $out;
      ln -s $cards $out/cards
    '';
    inherit cards rulebook;
    phases = ["installPhase"];
  };
in
all
