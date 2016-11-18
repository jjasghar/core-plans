pkg_name=rtorrent
pkg_version=0.9.6
pkg_origin=core
pkg_license=('GNU-GPL-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="rTorrent client uses ncurses and is ideal for use with tmux, screen or dtach. It supports saving of sessions, allows the user to add and remove torrents and many more.."
pkg_upstream_url=https://github.com/rakshasa/rtorrent
pkg_source=http://rtorrent.net/downloads/rtorrent-${pkg_version}.tar.gz
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_dirname=${pkg_name}-${pkg_version}
pkg_shasum=1e69c24f1f26f8f07d58d673480dc392bfc4317818c1115265b08a7813ff5b0e
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/coreutils
  core/curl
  core/file
  core/libtool
  core/gcc
  core/gcc-libs
  core/glibc
  core/ncurses
  core/m4
  core/make
  core/openssl
  core/pkg-config
  core/zlib
  jjasghar/rtorrent-libtorrent
  jjasghar/cppunit
)
pkg_bin_dirs=(bin)

do_build() {
  export OPENSSL_LIBS="-L$(pkg_path_for openssl)/lib"
  export PKG_CONFIG="$(pkg_path_for pkg-config)/bin/pkg-config"
  export libtorrent_LIBS="-L$(pkg_path_for rtorrent-libtorrent)/lib"
  export libtorrent_CFLAGS="-I$(pkg_path_for rtorrent-libtorrent)/include"
  export CC="$(pkg_path_for core/gcc)/bin/gcc"
  export CPP="$(pkg_path_for core/gcc)/bin/cpp"
  export CXX="$(pkg_path_for core/gcc)/bin/g++"
  export LD_LIBRARY_PATH="-L$(pkg_path_for core/gcc)/lib"
  export LD_INCLUDE_PATH="-I$(pkg_path_for core/gcc)/include"

  attach
  ./configure --prefix="${pkg_prefix}"

}
