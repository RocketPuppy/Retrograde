with (import <nixpkgs> {});
stdenv.mkDerivation {
  name = "retrograde-bundix";
  version = "0.1";
  src = ./.;
  dontConfigure = true;
  buildInputs = [
    ruby_2_6
    bundix pkg-config
    # cairo gem
    cairo gobject-introspection pcre xorg.libpthreadstubs xorg.libXdmcp
    # gio2 gem
    utillinux libselinux libsepol
    # gdk_pixbuf2 gem
    gdk-pixbuf rake rubyPackages_2_6.pkg-config rubyPackages_2_6.native-package-installer
    # nokogiri gem
    libxml2 libxslt
    # pango gem
    pango fribidi harfbuzz
    # rsvg2 gem
    librsvg
  ];

  shellHook = ''
    export NIX_PATH="${<nixpkgs>}"
  '';

  phases = [];
}
