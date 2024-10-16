# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Cross-platform, fast, feature-rich, GPU based terminal"
HOMEPAGE="https://github.com/kovidgoyal/kitty"
SRC_URI="https://github.com/kovidgoyal/kitty/releases/download/v0.24.4/kitty-0.24.4.tar.xz -> kitty-0.24.4.tar.xz"
S="${WORKDIR}/kitty-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
IUSE=""

BDEPEND="sys-libs/ncurses"

PATCHES=(
)

RESTRICT="test" # intended to be ran on the full kitty package

src_compile() { :; }

src_install() {
	dodir /usr/share/terminfo
	tic -xo "${ED}"/usr/share/terminfo terminfo/kitty.terminfo || die
}