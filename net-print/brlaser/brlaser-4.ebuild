# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Brother laser printer driver"
HOMEPAGE="https://github.com/pdewacht/brlaser"
SRC_URI="https://github.com/pdewacht/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="net-print/cups"
RDEPEND="
	${DEPEND}
	app-text/ghostscript-gpl"

src_prepare() {
	default
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_POLICY_VERSION_MINIMUM=3.5
	)

	cmake_src_configure
}
