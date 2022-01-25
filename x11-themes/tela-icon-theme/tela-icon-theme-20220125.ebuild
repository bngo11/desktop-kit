# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg

MY_PN="${PN/tela/Tela}"
DESCRIPTION="A flat colorful Design icon theme"
HOMEPAGE="https://www.pling.com/p/1279924"
SRC_URI="https://github.com/vinceliuice/tela-icon-theme/archive/2022-01-25.tar.gz -> tela-icon-theme-20220125.tar.gz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="*"
IUSE="+standard black blue brown green grey orange pink purple red yellow manjaro ubuntu"
REQUIRED_USE="|| ( standard black blue brown green grey orange pink purple red yellow manjaro ubuntu )"
RESTRICT="primaryuri"

BDEPEND="dev-util/gtk-update-icon-cache"

S="${WORKDIR}/${MY_PN}-2022-01-25"

src_install() {
	local colorvariant=(
		$(usev standard)
		$(usev black)
		$(usev blue)
		$(usev brown)
		$(usev green)
		$(usev grey)
		$(usev orange)
		$(usev pink)
		$(usev purple)
		$(usev red)
		$(usev yellow)
		$(usev ubuntu)
		$(usev manjaro)
	)

	einstalldocs

	dodir /usr/share/icons
	./install.sh -d "${D}/usr/share/icons" "${colorvariant[@]}" || die "The installation has failed"
}