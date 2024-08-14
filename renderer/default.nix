{ stdenv
, card-list
, assets
, upgrades
, spacecraft
, treaties
, doPrint ? false
, doImport ? true
, lib
, squib
, pkg-config
, ruby, rubyPackages
, cairo, gobject-introspection, pcre, libpthreadstubs, libXdmcp
, utillinux, libselinux, libsepol
, gdk-pixbuf, rake
, libxml2, libxslt
, pango, fribidi, harfbuzz
, librsvg
, which
}:
let
  printFlag = if doPrint then "-p" else "";
  importFlag = if doImport then "-i" else "";
in
stdenv.mkDerivation {
  name = "retrograde-cards-${lib.strings.removeSuffix ".csv" card-list.name}";
  version = "0.1";
  src = ./.;

  buildInputs = [
    which
    pkg-config
    # cairo gem
    cairo gobject-introspection pcre libpthreadstubs libXdmcp
    # gio2 gem
    utillinux libselinux libsepol
    # gdk_pixbuf2 gem
    gdk-pixbuf rake rubyPackages.pkg-config rubyPackages.native-package-installer
    # nokogiri gem
    libxml2 libxslt
    # pango gem
    pango fribidi harfbuzz
    # rsvg2 gem
    librsvg

    squib.wrappedRuby
  ];

  buildPhase = ''
    ruby main.rb $printFlag $importFlag -u $upgrades/upgrades.csv -a $assets/assets.csv -s $spacecraft/spacecraft.csv -t $treaties/treaties.csv --output="$PWD/build" $cardlist/*.csv
  '';

  cardlist = card-list;
  inherit card-list printFlag importFlag assets upgrades spacecraft treaties;

  installPhase = ''
    mkdir $out
    mv build/* $out
  '';

  phases = ["unpackPhase" "buildPhase" "installPhase"];
}
