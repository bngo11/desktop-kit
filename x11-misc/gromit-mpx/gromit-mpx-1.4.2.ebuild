# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Gromit-MPX is a multi-pointer GTK3 port of the Gromit desktop annotation tool"
HOMEPAGE="https://github.com/bk138/${PN}"

SRC_URI="https://github.com/bk138/gromit-mpx/archive/1.4.2.tar.gz -> gromit-mpx-1.4.2.tar.gz"
KEYWORDS="*"

SLOT="0"
LICENSE="GPL-2"

RDEPEND="
	x11-libs/gtk+:3
	dev-libs/libappindicator:3
	x11-libs/libX11
	>=x11-apps/xinput-1.3
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}"/etc
	)

	cmake_src_configure
}