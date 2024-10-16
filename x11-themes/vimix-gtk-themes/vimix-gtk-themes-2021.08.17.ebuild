# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A flat Material Design theme for GTK"
HOMEPAGE="https://github.com/vinceliuice/vimix-gtk-themes"

SRC_URI="https://api.github.com/repos/vinceliuice/vimix-gtk-themes/tarball/2021-08-17 -> vimix-gtk-themes-2021.08.17.tar.gz"
KEYWORDS="*"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	x11-libs/gtk+:3
	x11-themes/gtk-engines
	x11-themes/gtk-engines-murrine"
RDEPEND="${DEPEND}"

src_unpack() {
	default
	rm -rf ${S}
	mv ${WORKDIR}/vinceliuice-vimix-gtk-themes-* ${S} || die
}

src_install() {
	mkdir -p "${ED}"/usr/share/themes
	./install.sh -a -d "${ED}"/usr/share/themes || die
}