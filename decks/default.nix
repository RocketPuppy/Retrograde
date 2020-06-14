{ stdenvNoCC, card-data }:
stdenvNoCC.mkDerivation {
  pname = "retrograde-decks";
  version = "0.1";
  src = ./.;

  dontConfigure = true;

  buildInputs = [card-data];

  carddata = card-data;

  buildPhase = ''
    for f in $carddata/*.csv; do grep -E -o "^(\"[^\"]*\")|^([^,]+)" $f > $(basename $f); done
  '';

  installPhase = ''
    mkdir $out
    cp *.csv $out/
  '';

  phases = ["unpackPhase" "buildPhase" "installPhase"];
}
