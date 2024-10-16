# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake xdg

DESCRIPTION="KeePassXC - KeePass Cross-platform Community Edition"
HOMEPAGE="https://keepassxc.org"

SRC_URI="https://github.com/keepassxreboot/keepassxc/releases/download/2.6.6/keepassxc-2.6.6-src.tar.xz"
KEYWORDS="*"

LICENSE="LGPL-2.1 GPL-2 GPL-3"
SLOT="0"
IUSE="autotype browser debug keeshare +network test yubikey"

RDEPEND="
	app-crypt/argon2:=
	dev-libs/libgcrypt:=
	>=dev-libs/libsodium-1.0.12:=
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	media-gfx/qrencode:=
	sys-libs/readline:0=
	sys-libs/zlib:=
	autotype? (
		dev-qt/qtx11extras:5
		x11-libs/libX11
		x11-libs/libXi
		x11-libs/libXtst
	)
	keeshare? ( dev-libs/quazip )
	yubikey? ( sys-auth/ykpers )
"

DEPEND="
	${RDEPEND}
	dev-qt/linguist-tools:5
	dev-qt/qttest:5
"
# Not a runtime dependency but still needed (see bug #667092)
PDEPEND="x11-misc/xsel"

RESTRICT="!test? ( test )"

src_prepare() {
	use test || sed -e "/^find_package(Qt5Test/d" -i CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITH_GUI_TESTS=OFF
		-DWITH_TESTS="$(usex test)"
		-DWITH_XC_AUTOTYPE="$(usex autotype)"
		-DWITH_XC_DOCS=OFF
		-DWITH_XC_BROWSER="$(usex browser)"
		-DWITH_XC_FDOSECRETS=ON
		-DWITH_XC_KEESHARE="$(usex keeshare)"
		-DWITH_XC_NETWORKING="$(usex network)"
		-DWITH_XC_SSHAGENT=ON
		-DWITH_XC_UPDATECHECK=OFF
		-DWITH_XC_YUBIKEY="$(usex yubikey)"
	)
	if [[ "${PV}" == *_beta* ]] ; then
		mycmakeargs+=( -DOVERRIDE_VERSION="${PV/_/-}" )
	fi
	cmake_src_configure
}