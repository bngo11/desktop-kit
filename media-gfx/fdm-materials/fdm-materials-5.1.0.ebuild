# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="FDM materials for media-gfx/cura"
HOMEPAGE="https://github.com/Ultimaker/fdm_materials"
SRC_URI="https://github.com/Ultimaker/fdm_materials/tarball/031b2cd7613af29a80a0244d052188d0a014a437 -> fdm_materials-5.1.0-031b2cd.tar.gz"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="*"
IUSE="embedded"

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv Ultimaker-fdm_materials* "${S}" || die
	fi
}

src_configure() {
	local mycmakeargs=(
		-DEMBEDDED=$(usex embedded on off)
	)
	cmake_src_configure
}