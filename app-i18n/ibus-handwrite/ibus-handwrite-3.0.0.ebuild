# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Hand write recognition/input for IBus"
HOMEPAGE="https://github.com/microcai/ibus-handwrite"
SRC_URI="https://github.com/microcai/ibus-handwrite/releases/download/3.0/ibus-handwrite-3.0.0.tar.bz2 -> {repo}-{version}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls +zinnia"

RDEPEND="app-i18n/ibus
	x11-libs/gtk+:3
	x11-libs/gtkglext
	nls? ( virtual/libintl )
	zinnia? (
		app-i18n/zinnia
		app-i18n/zinnia-tomoe
	)"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

PATCHES=( "${FILESDIR}"/${PN}-headers.patch )

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_enable zinnia) \
		$(use_with zinnia zinnia-tomoe "${EPREFIX}"/usr/$(get_libdir)/zinnia/model/tomoe)
}
