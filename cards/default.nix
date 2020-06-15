{ stdenv
, card-data
, deck
, squib
, pkg-config
, ruby, rubyPackages
, cairo, gobject-introspection, pcre, libpthreadstubs, libXdmcp
, utillinux, libselinux, libsepol
, gdk-pixbuf, rake
, libxml2, libxslt
, pango, fribidi, harfbuzz
, librsvg
}:
stdenv.mkDerivation {
  name = "retrograde-cards";
  version = "0.1";
  src = ./.;

  buildInputs = [
    ruby
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

    squib
    deck
  ];

  # TODO: need type data files
  buildPhase = ''
    ruby main.rb -i -p -u ${card-data.byType.upgrades} -a ${card-data.byType.assets} -s ${card-data.byType.spacecraft} ${deck}
  '';

  installPhase = ''
    mkdir $out
    mv output $out
  '';

  phases = ["unpackPhase" "buildPhase" "installPhase"];
}
