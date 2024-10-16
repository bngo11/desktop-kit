# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="LXQt PolKit authentication agent"
HOMEPAGE="https://lxqt.github.io/"

SRC_URI="https://github.com/lxqt/lxqt-policykit/releases/download/1.0.0/lxqt-policykit-1.0.0.tar.xz -> lxqt-policykit-1.0.0.tar.xz"
KEYWORDS="*"

LICENSE="LGPL-2.1 LGPL-2.1+"
SLOT="0"

BDEPEND="
	dev-qt/linguist-tools:5
	dev-util/lxqt-build-tools
	virtual/pkgconfig
"
DEPEND="
	dev-libs/glib:2
	dev-libs/libqtxdg
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	=lxqt-base/liblxqt-$(ver_cut 1-2)*
	sys-auth/polkit-qt
"
RDEPEND="${DEPEND}"

src_install() {
	cmake_src_install
	doman man/*.1
}