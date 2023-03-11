# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="FDM materials for media-gfx/cura"
HOMEPAGE="https://github.com/Ultimaker/fdm_materials"
SRC_URI="https://github.com/Ultimaker/fdm_materials/tarball/9c97d6f1f97237cf856cb12ce68c791e73524e4d -> fdm_materials-5.3.0-9c97d6f.tar.gz"

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