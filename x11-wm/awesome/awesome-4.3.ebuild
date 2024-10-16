# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake desktop pax-utils


DESCRIPTION="awesome window manager"
HOMEPAGE="https://awesomewm.org/"
SRC_URI="https://github.com/awesomeWM/awesome/tarball/5da5d36178250335f748eed43551daad9e5af694 -> awesome-4.3-5da5d36.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="dbus doc gnome luajit"

REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="
	dev-lang/lua
	luajit? ( dev-lang/luajit:2 )
	dev-libs/glib:2
	dev-libs/libxdg-basedir
	dev-lua/lgi
	x11-libs/cairo[X,xcb(+)]
	x11-libs/gdk-pixbuf:2
	x11-libs/libxcb[xkb]
	x11-libs/pango[introspection]
	x11-libs/startup-notification
	x11-libs/xcb-util
	x11-libs/xcb-util-cursor
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-wm
	x11-libs/xcb-util-xrm
	x11-libs/libXcursor
	x11-libs/libxkbcommon[X]
	x11-libs/libX11
	dbus? ( sys-apps/dbus )
"

DEPEND="
	${RDEPEND}
	x11-base/xcb-proto
	x11-base/xorg-proto
"

BDEPEND="app-text/asciidoc
	media-gfx/imagemagick[png]
	virtual/pkgconfig
	doc? ( dev-lua/ldoc )"

# Skip installation of README.md by einstalldocs, which leads to broken symlink
DOCS=()

# Ensure that this can be compiled by gcc-9 and above
PATCHES=( "${FILESDIR}"/${P}-fno-common.patch )

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv awesomeWM-awesome* "${S}"
	fi
}

src_prepare() {
	# Fix convert path
	sed -i -e "s|convert|bin/convert|g" awesomeConfig.cmake

	# Fix desktop file
	sed -i -e "s|^Exec=.*$|Exec=/etc/X11/Sessions/awesome|g" awesome.desktop

	# Clean up cflags
	sed -i -e "s|-O1||g" -e "s|-ggdb3||g" CMakeLists.txt

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DSYSCONFDIR="${EPREFIX}"/etc
		-DCOMPRESS_MANPAGES=OFF
		-DWITH_DBUS=$(usex dbus)
		-DGENERATE_DOC=$(usex doc)
		-DAWESOME_DOC_PATH="${EPREFIX}"/usr/share/doc/${PF}
	)

	if use luajit; then
		mycmakeargs+=("-DLUA_INCLUDE_DIR=${EPREFIX}/usr/include/luajit-2.0")
		mycmakeargs+=("-DLUA_LIBRARY=${EPREFIX}/usr/$(get_libdir)/libluajit-5.1.so")
	fi

	cmake_src_configure
}

src_install() {
	cmake_src_install
	rm "${ED}"/usr/share/doc/${PF}/LICENSE || die

	pax-mark m "${ED}"/usr/bin/awesome

	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}"/${PN}-session ${PN}

	# GNOME-based awesome
	if use gnome; then
		# GNOME session
		insinto /usr/share/gnome-session/sessions
		newins "${FILESDIR}"/${PN}-gnome-3.session ${PN}-gnome.session

		# Application launcher
		domenu "${FILESDIR}"/${PN}-gnome.desktop

		# X Session
		insinto /usr/share/xsessions
		doins "${FILESDIR}"/${PN}-gnome-xsession.desktop
	fi

	# This directory contains SVG images which we don't want to compress
	use doc && docompress -x /usr/share/doc/${PF}/doc
}

pkg_postinst() {
	if use gnome; then
		elog "You have enabled the gnome USE flag."
		elog "Please note that quitting awesome won't kill your gnome session."
		elog "To really quit the session, you should bind your quit key"
		elog "to the following command:"
		elog "  gnome-session-quit --logout"
		elog "For more info visit"
		elog "  https://bugs.gentoo.org/show_bug.cgi?id=447308"
	fi

	elog "If you are having issues with Java application windows being"
	elog "completely blank, try installing"
	elog "  x11-misc/wmname"
	elog "and setting the WM name to LG3D."
	elog "For more info visit"
	elog "  https://bugs.gentoo.org/show_bug.cgi?id=440724"
}