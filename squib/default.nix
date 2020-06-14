{ lib
, bundlerEnv, defaultGemConfig
, ruby, rubyPackages
, pkgconfig
, rake
, librsvg
, pkg-config
, cairo, gobject-introspection, pcre, libpthreadstubs, libXdmcp
, utillinux, libselinux, libsepol
, gdk-pixbuf
, libxml2, libxslt
, pango, fribidi, harfbuzz
}:
let
  gemConfig = defaultGemConfig // {
    rsvg2 = attrs: {
      nativeBuildInputs = [pkgconfig rake];
      buildInputs = [ librsvg ];
    };
  };
in
bundlerEnv {
  pname = "squib";
  gemdir = ./.;
  exes = [ "squib" ];
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
  ];
  inherit gemConfig ruby;

  meta = with lib; {
    description = "Squib is a Ruby DSL for prototyping card games";
    homepage    = https://github.com/andymeneely/squib;
    license     = licenses.mit;
  };
}
