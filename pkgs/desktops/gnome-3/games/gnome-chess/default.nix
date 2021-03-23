{ lib, stdenv, fetchurl, meson, ninja, vala, pkg-config, wrapGAppsHook, gobject-introspection
, gettext, itstool, libxml2, python3, gnome3, glib, gtk3, librsvg }:

stdenv.mkDerivation rec {
  pname = "gnome-chess";
  version = "40.0";

  src = fetchurl {
    url = "mirror://gnome/sources/gnome-chess/${lib.versions.major version}/${pname}-${version}.tar.xz";
    sha256 = "0c4nfyi3frl94vjsfp3r07k7g7ffwf8dg5qyq1580mxmks0gigr5";
  };

  nativeBuildInputs = [ meson ninja vala pkg-config gettext itstool libxml2 python3 wrapGAppsHook gobject-introspection ];
  buildInputs = [ glib gtk3 librsvg gnome3.adwaita-icon-theme ];

  postPatch = ''
    chmod +x meson_post_install.py
    patchShebangs meson_post_install.py
  '';

  passthru = {
    updateScript = gnome3.updateScript {
      packageName = "gnome-chess";
      attrPath = "gnome3.gnome-chess";
    };
  };

  meta = with lib; {
    homepage = "https://wiki.gnome.org/Apps/Chess";
    description = "Play the classic two-player boardgame of chess";
    maintainers = teams.gnome.members;
    license = licenses.gpl2;
    platforms = platforms.linux;
  };
}
