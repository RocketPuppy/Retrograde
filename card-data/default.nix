{ stdenvNoCC }:
stdenvNoCC.mkDerivation {
  pname = "retrograde-card-data";
  version = "0.1";
  src = ./.;

  dontConfigure = true;

  buildInputs = [];

  installPhase = ''
    mkdir $out
    cp *.csv $out/
  '';

  phases = ["unpackPhase" "installPhase"];
}
