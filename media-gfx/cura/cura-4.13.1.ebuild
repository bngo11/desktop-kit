# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3+ )
inherit cmake-utils fdo-mime gnome2-utils python-single-r1

MY_PN=Cura

DESCRIPTION="A 3D model slicing application for 3D printing"
HOMEPAGE="https://github.com/Ultimaker/Cura"
SRC_URI="https://github.com/Ultimaker/Cura/archive/4.13.1.tar.gz -> Cura-4.13.1.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="*"
IUSE="+usb zeroconf"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	>=media-gfx/curaengine-${PV:0:3}
	>=media-gfx/fdm-materials-${PV:0:3}
	>=dev-libs/libsavitar-${PV:0:3}:=[python,${PYTHON_USEDEP}]
	>=dev-libs/libcharon-${PV:0:3}[${PYTHON_USEDEP}]
	>=sci-libs/Shapely-1.7.0[${PYTHON_USEDEP}]
	>=dev-python/uranium-${PV:0:3}[${PYTHON_USEDEP}]
	usb? ( dev-python/pyserial[${PYTHON_USEDEP}] )
	zeroconf? ( dev-python/zeroconf[${PYTHON_USEDEP}] )"

DEPEND="${RDEPEND}
	sys-devel/gettext"

S="${WORKDIR}/${MY_PN}-${PV}"
DOCS=( README.md )
PATCHES=( "${FILESDIR}/cura-4.5.0-disable-translations.patch" )

src_prepare() {
	default
}

src_configure() {
	local mycmakeargs=(
		-DPYTHON_SITE_PACKAGES_DIR="$(python_get_sitedir)"
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	doicon icons/*.png
	python_optimize "${D}${get_libdir}"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}