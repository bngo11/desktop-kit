# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg-utils

DESCRIPTION="Qt GUI Tabbed Filemanager"
HOMEPAGE="https://lxqt.github.io/"

SRC_URI="https://github.com/lxqt/pcmanfm-qt/releases/download/1.0.0/pcmanfm-qt-1.0.0.tar.xz -> pcmanfm-qt-1.0.0.tar.xz"
KEYWORDS="*"

LICENSE="GPL-2 GPL-2+ LGPL-2.1+"
SLOT="0"

BDEPEND="
	dev-qt/linguist-tools:5
	dev-util/lxqt-build-tools
"
DEPEND="
	dev-libs/glib:2
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	=x11-libs/libfm-qt-$(ver_cut 1-2)*
	x11-libs/libxcb:=
	x11-misc/xdg-utils
	virtual/eject
	virtual/freedesktop-icon-theme
"
RDEPEND="${DEPEND}
	lxde-base/lxmenu-data
"

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}