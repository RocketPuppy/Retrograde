{ stdenvNoCC
, texlive
, inkscape
, cards
}:

let
  latex = texlive.combine {
    inherit (texlive)
      scheme-medium
      geometry
      easylist
      wrapfig
      svg
      trimspaces
      transparent
      catchfile;
    };
in
stdenvNoCC.mkDerivation {
  pname = "retrograde-rulebook";
  version = "0.1";
  src = ./.;

  dontConfigure = true;

  buildInputs = [ inkscape latex cards ];

  inherit cards;

  buildPhase = ''
    echo "\graphicspath{" > graphicspath.tex
    for c in $cards; do
      echo "{$c/singles/}" >> graphicspath.tex
    done
    echo "}" >> graphicspath.tex
    pdflatex --shell-escape -no-mktex=pk rulebook.tex
  '';

  installPhase = ''
    mkdir $out
    cp rulebook.pdf $out/rulebook.pdf
  '';

  phases = ["unpackPhase" "buildPhase" "installPhase"];
}
