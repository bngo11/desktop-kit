# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )

inherit meson python-any-r1 xdg-utils

DESCRIPTION="Feature rich terminal emulator using the Enlightenment Foundation Libraries"
HOMEPAGE="https://www.enlightenment.org/about-terminology"
SRC_URI="https://download.enlightenment.org/rel/apps/terminology/terminology-1.12.1.tar.xz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="*"
IUSE="extras nls"

RDEPEND="|| ( dev-libs/efl[gles2-only] dev-libs/efl[opengl] )
	|| ( dev-libs/efl[X] dev-libs/efl[wayland] )
	app-arch/lz4
	dev-libs/efl[eet,fontconfig]"
DEPEND="${RDEPEND}"
BDEPEND="${PYTHON_DEPS}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_setup() {
	python-any-r1_pkg_setup
}

src_prepare() {
	default

	# Fix python shebangs for python-exec[-native-symlinks], Gentoo bug #766081
	local shebangs=($(grep -rl "#!/usr/bin/env python3" || die))
	python_fix_shebang -q ${shebangs[*]}
}

src_configure() {
	local emesonargs=(
		$(meson_use nls)
		$(meson_use extras tests)
	)

	meson_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}