let source = rec {
        owner = "NixOS";
        repo = "nixpkgs-channels";
        rev = "fb6c3a6831ca5c5a9d923fed1db3c2006a118681";
        sha256 = "0kw99wmwzb5lvylcl1npyvw7lxrrk4bjbsjbjcgnyaxajkmclzqa";
        name = "${repo}-${rev}";
      };
in
import ((import <nixpkgs> {}).fetchFromGitHub source)
