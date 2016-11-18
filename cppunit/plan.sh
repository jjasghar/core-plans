pkg_name=cppunit
pkg_version=1.13.2
pkg_origin=core
pkg_license=('GNU-GPL-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="CppUnit is the C++ port of the famous JUnit framework for unit testing. Test output is in XML for automatic testing and GUI based for supervised tests."
pkg_upstream_url=https://freedesktop.org/wiki/Software/cppunit/
pkg_source=git://anongit.freedesktop.org/git/libreoffice/cppunit/
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_dirname=${pkg_name}-${pkg_version}
pkg_shasum=
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/coreutils
  core/libtool
  core/gcc
  core/gcc-libs
  core/git
  core/glibc
  core/m4
  core/make
  core/pkg-config
  core/which
  core/zlib
)
pkg_bin_dirs=(bin)

do_download() {
  pushd "$HAB_CACHE_SRC_PATH"
  rm -rf cppunit
  git clone "$pkg_source"
  popd
}

do_unpack() {
  return 0
}


do_build() {
  export PKG_CONFIG="$(pkg_path_for pkg-config)/bin/pkg-config"
  export libtorrent_LIBS="-L$(pkg_path_for libtorrent-rtorrent)/lib"
  export libtorrent_CFLAGS="-I$(pkg_path_for libtorrent-rtorrent)/include"
  export CC="$(pkg_path_for core/gcc)/bin/gcc"
  export CPP="$(pkg_path_for core/gcc)/bin/cpp"
  export CXX="$(pkg_path_for core/gcc)/bin/g++"
  export LD_LIBRARY_PATH="$(pkg_path_for core/gcc)/lib"
  export LD_INCLUDE_PATH="$(pkg_path_for core/gcc)/include"

  cd "${HAB_CACHE_SRC_PATH}/cppunit"
  ./autogen.sh
  ./configure --prefix="${pkg_prefix}"
}

do_check() {
  make check
}

do_install() {
  cd "${HAB_CACHE_SRC_PATH}/cppunit"
  make
  make install
}
