# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="improved screen locker"
HOMEPAGE="https://i3wm.org/i3lock/"
SRC_URI="https://github.com/i3/i3lock/tarball/01713948829dc36944cb79db89881b8ad56d5a37 -> i3lock-2.14-0171394.tar.gz"
KEYWORDS="*"

LICENSE="BSD"
SLOT="0"

RDEPEND="
	dev-libs/libev
	sys-libs/pam
	x11-libs/cairo[X,xcb(+)]
	x11-libs/libxcb[xkb]
	x11-libs/libxkbcommon[X]
	x11-libs/xcb-util
	x11-libs/xcb-util-xrm"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

post_src_unpack() {
	mv "${WORKDIR}/"i3-i3lock* "${S}" || die
}

src_prepare() {
	default

	sed -i -e 's:login:system-auth:g' pam/${PN} || die
}

src_install() {
	default
	doman ${PN}.1
}