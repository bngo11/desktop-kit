# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A Gtk theme based on Material Design Refresh."
HOMEPAGE="https://gitlab.com/tista500/plata-theme"
SRC_URI="https://gitlab.com/tista500/plata-theme/-/archive/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="cinnamon flashback +gtk4 mate openbox parallel telegram xfce"

DEPEND="media-fonts/roboto
		media-gfx/inkscape
		sys-devel/autoconf
		sys-devel/automake
		>=x11-libs/gdk-pixbuf-2.32.2
		>=dev-libs/glib-2.48.0
		>=x11-libs/gtk+-2.24.0:2
		>=x11-libs/gtk+-3.20.0:3
		gtk4? ( x11-libs/gtk )
		parallel? ( sys-process/parallel )
		telegram? ( app-arch/zip
					net-im/telegram-desktop-bin )
		mate? ( x11-wm/marco )
		virtual/pkgconfig
		>=dev-lang/sassc-3.3
"
RDEPEND="${DEPEND}"

src_configure() {
	local myconf=(
		$(use_enable cinnamon)
		$(use_enable flashback)
		$(use_enable gtk4 gtk_next)
		$(use_enable mate)
		$(use_enable openbox)
		$(use_enable parallel)
		$(use_enable telegram)
		$(use_enable xfce)
	)

	sh ./autogen.sh --prefix=/usr "${myconf[@]}"
}

src_compile() {
	emake
}