# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )

inherit meson python-any-r1

DESCRIPTION="EDID and DisplayID library"
HOMEPAGE="https://gitlab.freedesktop.org/emersion/libdisplay-info"
SRC_URI="https://gitlab.freedesktop.org/emersion/${PN}/-/releases/${PV}/downloads/${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

RDEPEND="sys-apps/hwdata"
DEPEND="${RDEPEND}"

BDEPEND="
	${PYTHON_DEPS}
	virtual/pkgconfig
"
