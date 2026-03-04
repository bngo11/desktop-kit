# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A tiling window manager"
HOMEPAGE="https://github.com/jcs/sdorfehs"
SRC_URI="https://github.com/jcs/sdorfehs/tarball/21072a06f840f1f7ae01b9e004b5a9fc9f207763 -> sdorfehs-1.7-21072a0.tar.gz"

LICENSE="GPL-2.0"
SLOT="0"
KEYWORDS="*"

IUSE="debug emacs +history sloppy +xft +xrandr"

RDEPEND="
	history? ( sys-libs/readline:= )
	xft? ( x11-libs/libXft )
	xrandr? ( x11-libs/libXrandr )
	x11-libs/libX11
	x11-libs/libXtst
	x11-libs/libXres
"
DEPEND="
	${RDEPEND}
	x11-base/xorg-proto
"
BDEPEND="virtual/pkgconfig"

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv jcs-sdorfehs* "${S}"
	fi
}