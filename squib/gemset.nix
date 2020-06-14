{
  cairo = {
    dependencies = ["native-package-installer" "pkg-config"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1fjv110ap274mghyrc0pls1hhlxyp0bhx1kc62q2p45nfhyj87zi";
      type = "gem";
    };
    version = "1.16.5";
  };
  cairo-gobject = {
    dependencies = ["cairo" "glib2"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "136aa800dgq6bmr0lb59mfj5q72r712wwp5wy5qxnp48adjw1k2h";
      type = "gem";
    };
    version = "3.4.3";
  };
  classy_hash = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0l7sn8x580vzhv0cv25ixnncmz0dblwrwygvph71zsphq4fqcxmf";
      type = "gem";
    };
    version = "0.2.1";
  };
  gdk_pixbuf2 = {
    dependencies = ["gio2"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0hslcfns2ysvjyj21hjvp4hghrafw1sdl627fm0nj0wsncs94m67";
      type = "gem";
    };
    version = "3.4.3";
  };
  gio2 = {
    dependencies = ["gobject-introspection"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1l30xsr1dgnzqfmln17arnqi8iga97ldf6zgbqrfby6a94v3ammd";
      type = "gem";
    };
    version = "3.4.3";
  };
  glib2 = {
    dependencies = ["native-package-installer" "pkg-config"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0l46ymdf7azpd137xq4rarbaq54hxs9rgfry0r6b0ywj74rmw9ih";
      type = "gem";
    };
    version = "3.4.3";
  };
  gobject-introspection = {
    dependencies = ["glib2"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "11gas9hzq36a2bwqi7h5c6p6jihanbhsarwhv5fw53dxap4iwj25";
      type = "gem";
    };
    version = "3.4.3";
  };
  highline = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1g0zpalfj8wvca86hcnirir5py2zyqrhkgdgv9f87fxkjaw815wr";
      type = "gem";
    };
    version = "2.0.2";
  };
  mercenary = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "10la0xw82dh5mqab8bl0dk21zld63cqxb1g16fk8cb39ylc4n21a";
      type = "gem";
    };
    version = "0.3.6";
  };
  mini_portile2 = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "15zplpfw3knqifj9bpf604rb3wc1vhq6363pd6lvhayng8wql5vy";
      type = "gem";
    };
    version = "2.4.0";
  };
  native-package-installer = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0piclgf6pw7hr10x57x0hn675djyna4sb3xc97yb9vh66wkx1fl0";
      type = "gem";
    };
    version = "1.0.9";
  };
  nokogiri = {
    dependencies = ["mini_portile2"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0nmdrqqz1gs0fwkgzxjl4wr554gr8dc1fkrqjc2jpsvwgm41rygv";
      type = "gem";
    };
    version = "1.10.4";
  };
  pango = {
    dependencies = ["cairo-gobject" "gobject-introspection"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "05smxn2jank7wqih59lhr30ab8f4qxdsdiiag5v7a0gjgzkmbi7f";
      type = "gem";
    };
    version = "3.4.3";
  };
  pkg-config = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1wjfdf7yzi8wgbfb53xlyp8mnak2ssg2iqax3kv3zz2dadc7ma6w";
      type = "gem";
    };
    version = "1.4.1";
  };
  roo = {
    dependencies = ["nokogiri" "rubyzip"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1rh5z97f0a0gd8njvlgm9m8d35fqxqck3z3m2rk8siawcr3yjhdn";
      type = "gem";
    };
    version = "2.8.2";
  };
  rsvg2 = {
    dependencies = ["cairo-gobject" "gdk_pixbuf2"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0rfgaijqpvv2iiczp9c8ycnhivaif1kx6gvv96122xy57llg5yx8";
      type = "gem";
    };
    version = "3.4.3";
  };
  ruby-progressbar = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1k77i0d4wsn23ggdd2msrcwfy0i376cglfqypkk2q77r2l3408zf";
      type = "gem";
    };
    version = "1.10.1";
  };
  rubyzip = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1qxc2zxwwipm6kviiar4gfhcakpx1jdcs89v6lvzivn5hq1xk78l";
      type = "gem";
    };
    version = "1.3.0";
  };
  squib = {
    dependencies = ["cairo" "classy_hash" "gio2" "gobject-introspection" "highline" "mercenary" "nokogiri" "pango" "roo" "rsvg2" "ruby-progressbar"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1p1jajxvznv8g258si1aacqifxgr1x570r06m3pxhhxyk9884ga3";
      type = "gem";
    };
    version = "0.15.3";
  };
}