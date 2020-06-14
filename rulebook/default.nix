{ stdenvNoCC
, texlive
, cards
}:

let
  latex = texlive.combine {
    inherit (texlive)
      scheme-small
      geometry
      easylist
      wrapfig;
    };
in
stdenvNoCC.mkDerivation {
  pname = "retrograde-rulebook";
  version = "0.1";
  src = ./.;

  dontConfigure = true;

  buildInputs = [ latex cards ];

  inherit cards;

  buildPhase = ''
    echo "\graphicspath{{$cards/output/import/}}" > graphicspath.tex
    pdflatex rulebook.tex
  '';

  installPhase = ''
    mkdir $out
    cp rulebook.pdf $out/rulebook.pdf
  '';

  phases = ["unpackPhase" "buildPhase" "installPhase"];
}
