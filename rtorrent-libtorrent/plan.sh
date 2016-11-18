pkg_name=rtorrent-libtorrent
pkg_version=0.13.6
pkg_origin=core
pkg_license=('GNU-GPL-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="rTorrent client uses ncurses and is ideal for use with tmux, screen or dtach. It supports saving of sessions, allows the user to add and remove torrents and many more.."
pkg_upstream_url=https://github.com/rakshasa/rtorrent
pkg_source=http://rtorrent.net/downloads/libtorrent-${pkg_version}.tar.gz
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_dirname=libtorrent-${pkg_version}
pkg_shasum=2838a08c96edfd936aff8fbf99ecbb930c2bfca3337dd1482eb5fccdb80d5a04
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make core/coreutils core/zlib core/openssl core/pkg-config)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_build() {
  export OPENSSL_LIBS="$(pkg_path_for openssl)/lib"
  export PKG_CONFIG="$(pkg_path_for pkg-config)/bin"/pkg-config

  ./configure --prefix="${pkg_prefix}"
}
