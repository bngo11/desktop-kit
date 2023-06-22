# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="FDM materials for media-gfx/cura"
HOMEPAGE="https://github.com/Ultimaker/fdm_materials"
SRC_URI="https://github.com/Ultimaker/fdm_materials/tarball/384ab9c22f3f32f0e0721dfda54a9db637967a2d -> fdm_materials-2019.08.21-384ab9c.tar.gz"

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