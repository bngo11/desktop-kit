# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="LXQt quick launcher"
HOMEPAGE="https://lxqt.github.io/"

MY_PV="$(ver_cut 1-2)*"

SRC_URI="https://github.com/lxqt/lxqt-runner/releases/download/1.0.0/lxqt-runner-1.0.0.tar.xz -> lxqt-runner-1.0.0.tar.xz"
KEYWORDS="*"

LICENSE="LGPL-2.1 LGPL-2.1+"
SLOT="0"

BDEPEND="
	dev-qt/linguist-tools:5
	dev-util/lxqt-build-tools
	virtual/pkgconfig
"
DEPEND="
	dev-cpp/muParser
	dev-libs/libqtxdg
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	kde-frameworks/kwindowsystem:5
	=lxqt-base/liblxqt-${MY_PV}
	=lxqt-base/lxqt-globalkeys-${MY_PV}
"
RDEPEND="${DEPEND}"

src_install() {
	cmake_src_install
	doman man/*.1
}