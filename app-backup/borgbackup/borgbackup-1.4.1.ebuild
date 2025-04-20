# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="Deduplicated, encrypted, authenticated and compressed backups"
HOMEPAGE="None https://pypi.org/project/borgbackup/"
SRC_URI="https://files.pythonhosted.org/packages/d3/8b/f24d8ab37b8d8cd85a55fa6cfaf98754bb7b6c7534c03ffe087506080a53/borgbackup-1.4.1.tar.gz -> borgbackup-1.4.1.tar.gz"

DEPEND="
	!!app-office/borg
	app-arch/lz4
	virtual/acl
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	dev-python/cython[${PYTHON_USEDEP}]"
RDEPEND="
	${DEPEND}
	dev-python/llfuse[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]"
IUSE="libressl"
SLOT="0"
LICENSE="BSD"
KEYWORDS="*"
S="${WORKDIR}/borgbackup-1.4.1"

python_prepare_all() {
	# allow use of new (renamed) msgpack
	sed -i "s|'msgpack-python.*',||g" setup.py || die
	distutils-r1_python_prepare_all
}

src_compile() {
	BORG_OPENSSL_PREFIX=/usr distutils-r1_src_compile
}

src_install() {
	BORG_OPENSSL_PREFIX=/usr distutils-r1_src_install
}
