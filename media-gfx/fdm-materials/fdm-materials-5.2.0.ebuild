# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="FDM materials for media-gfx/cura"
HOMEPAGE="https://github.com/Ultimaker/fdm_materials"
SRC_URI="https://github.com/Ultimaker/fdm_materials/tarball/96faf782f345be50be1a05d9a97a5d0892d034ad -> fdm_materials-5.2.0-96faf78.tar.gz"

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