# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )

inherit distutils-r1

DESCRIPTION="Generate and change color-schemes on the fly"
HOMEPAGE="https://github.com/dylanaraps/pywal"

SRC_URI="https://github.com/dylanaraps/pywal/archive/3.3.0.tar.gz -> pywal-3.3.0.tar.gz"
KEYWORDS="*"

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	media-gfx/imagemagick
"
BDEPEND=""