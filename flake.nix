{
  description = "Retrograde Cards";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.retrograde-cards = pkgs.stdenv.mkDerivation {
          name = "retrograde-cards.tar";
          src = ./.;

          buildInputs = [
            pkgs.inkscape
            (pkgs.python3.withPackages (p: [ p.inkex ]))
          ];

          buildPhase = ''
            runHook preBuild

            python3 $src/countersheet.py --data $src/cards.csv --bitmapw 496 --bitmaph 693 --bitmapdir ./. --bitmapsheetsdpi 0 $src/cards.svg > /dev/null

            runHook postBuild
          '';

          installPhase = ''
            runHook preInstall

            tar -cf $out *.png

            runHook postInstall
          '';
        };

        packages.default = self.packages.${system}.retrograde-cards;
      }
    );
}
