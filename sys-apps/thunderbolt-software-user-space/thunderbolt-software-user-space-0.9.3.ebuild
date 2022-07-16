# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake linux-info

DESCRIPTION="Thunderbolt(TM) user-space components"
HOMEPAGE="https://github.com/intel/thunderbolt-software-user-space"
SRC_URI="https://github.com/intel/thunderbolt-software-user-space/archive/v0.9.3.tar.gz -> thunderbolt-software-user-space-0.9.3.tar.gz
         https://dev.gentoo.org/~asturm/distfiles/thunderbolt-software-user-space-0.9.3-tbtadm.1.tar.xz -> thunderbolt-software-user-space-0.9.3-tbtadm.1.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"
IUSE=""

# man needs app-text/txt2tags which is dormant upstream, so it is shipped pregenerated
DEPEND="dev-libs/boost:="
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-cmake.patch" )

pkg_pretend() {
	CONFIG_CHECK="THUNDERBOLT"
	ERROR_THUNDERBOLT="This program talks to the thunderbolt kernel driver, so please enable it."
	CONFIG_CHECK="HOTPLUG_PCI"
	ERROR_HOTPLUG_PCI="Thunderbolt needs pci hotplug support, so please enable it."
	check_extra_config
}

src_prepare() {
	cmake_src_prepare
	cmake_comment_add_subdirectory docs
}

src_install() {
	cmake_src_install
	doman tbtadm.1
}