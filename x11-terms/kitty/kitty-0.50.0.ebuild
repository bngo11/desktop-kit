# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_9+ )

inherit python-single-r1 toolchain-funcs xdg go-module
EGO_SUM=(
	"github.com/!a!l!tree/bigfloat v0.3.0"
	"github.com/!a!l!tree/bigfloat v0.3.0/go.mod"
	"github.com/alecthomas/assert/v2 v2.11.0"
	"github.com/alecthomas/assert/v2 v2.11.0/go.mod"
	"github.com/alecthomas/chroma/v2 v2.27.0"
	"github.com/alecthomas/chroma/v2 v2.27.0/go.mod"
	"github.com/alecthomas/repr v0.5.2"
	"github.com/alecthomas/repr v0.5.2/go.mod"
	"github.com/bmatcuk/doublestar/v4 v4.10.4"
	"github.com/bmatcuk/doublestar/v4 v4.10.4/go.mod"
	"github.com/dlclark/regexp2 v1.12.0"
	"github.com/dlclark/regexp2 v1.12.0/go.mod"
	"github.com/dlclark/regexp2/v2 v2.2.1"
	"github.com/dlclark/regexp2/v2 v2.2.1/go.mod"
	"github.com/ebitengine/purego v0.11.2"
	"github.com/ebitengine/purego v0.11.2/go.mod"
	"github.com/emmansun/base64 v0.11.0"
	"github.com/emmansun/base64 v0.11.0/go.mod"
	"github.com/go-ole/go-ole v1.2.6"
	"github.com/go-ole/go-ole v1.2.6/go.mod"
	"github.com/google/go-cmp v0.5.9/go.mod"
	"github.com/google/go-cmp v0.7.0"
	"github.com/google/go-cmp v0.7.0/go.mod"
	"github.com/google/uuid v1.6.0"
	"github.com/google/uuid v1.6.0/go.mod"
	"github.com/hako/durafmt v0.0.0-20210608085754-5c1018a4e16b"
	"github.com/hako/durafmt v0.0.0-20210608085754-5c1018a4e16b/go.mod"
	"github.com/hexops/gotextdiff v1.0.3"
	"github.com/hexops/gotextdiff v1.0.3/go.mod"
	"github.com/jessevdk/go-flags v1.4.0/go.mod"
	"github.com/klauspost/compress v1.20.3"
	"github.com/klauspost/compress v1.20.3/go.mod"
	"github.com/klauspost/cpuid/v2 v2.2.10"
	"github.com/klauspost/cpuid/v2 v2.2.10/go.mod"
	"github.com/kovidgoyal/dbus v0.0.0-20250519011319-e811c41c0bc1"
	"github.com/kovidgoyal/dbus v0.0.0-20250519011319-e811c41c0bc1/go.mod"
	"github.com/kovidgoyal/go-parallel v1.1.1"
	"github.com/kovidgoyal/go-parallel v1.1.1/go.mod"
	"github.com/kovidgoyal/go-shm v1.0.0"
	"github.com/kovidgoyal/go-shm v1.0.0/go.mod"
	"github.com/kovidgoyal/go-shm/v2 v2.0.1"
	"github.com/kovidgoyal/go-shm/v2 v2.0.1/go.mod"
	"github.com/kovidgoyal/imaging v1.9.0"
	"github.com/kovidgoyal/imaging v1.9.0/go.mod"
	"github.com/lufia/plan9stats v0.0.0-20230326075908-cb1d2100619a"
	"github.com/lufia/plan9stats v0.0.0-20230326075908-cb1d2100619a/go.mod"
	"github.com/nwaples/rardecode/v2 v2.4.5"
	"github.com/nwaples/rardecode/v2 v2.4.5/go.mod"
	"github.com/power-devops/perfstat v0.0.0-20260805114148-88456608a4f6"
	"github.com/power-devops/perfstat v0.0.0-20260805114148-88456608a4f6/go.mod"
	"github.com/rwcarlsen/goexif v0.0.0-20190401172101-9e8deecbddbd"
	"github.com/rwcarlsen/goexif v0.0.0-20190401172101-9e8deecbddbd/go.mod"
	"github.com/seancfoley/bintree v1.4.0"
	"github.com/seancfoley/bintree v1.4.0/go.mod"
	"github.com/seancfoley/ipaddress-go v1.8.4"
	"github.com/seancfoley/ipaddress-go v1.8.4/go.mod"
	"github.com/sgtdi/fswatcher v1.3.0"
	"github.com/sgtdi/fswatcher v1.3.0/go.mod"
	"github.com/shirou/gopsutil/v4 v4.26.10"
	"github.com/shirou/gopsutil/v4 v4.26.10/go.mod"
	"github.com/stretchr/testify v1.12.1"
	"github.com/stretchr/testify v1.12.1/go.mod"
	"github.com/tklauser/go-sysconf v0.4.0"
	"github.com/tklauser/go-sysconf v0.4.0/go.mod"
	"github.com/tklauser/numcpus v0.12.0"
	"github.com/tklauser/numcpus v0.12.0/go.mod"
	"github.com/ulikunitz/xz v0.5.17"
	"github.com/ulikunitz/xz v0.5.17/go.mod"
	"github.com/yusufpapurcu/wmi v1.2.4"
	"github.com/yusufpapurcu/wmi v1.2.4/go.mod"
	"github.com/zeebo/assert v1.3.0"
	"github.com/zeebo/assert v1.3.0/go.mod"
	"github.com/zeebo/xxh3 v1.1.0"
	"github.com/zeebo/xxh3 v1.1.0/go.mod"
	"go.yaml.in/yaml/v3 v3.0.5"
	"go.yaml.in/yaml/v3 v3.0.5/go.mod"
	"golang.org/x/exp v0.0.0-20230801115018-d63ba01acd4b"
	"golang.org/x/exp v0.0.0-20230801115018-d63ba01acd4b/go.mod"
	"golang.org/x/image v0.47.0"
	"golang.org/x/image v0.47.0/go.mod"
	"golang.org/x/sys v0.0.0-20190916202348-b4ddaad3f8a3/go.mod"
	"golang.org/x/sys v0.0.0-20201204225414-ed752295db88/go.mod"
	"golang.org/x/sys v0.49.0"
	"golang.org/x/sys v0.49.0/go.mod"
	"golang.org/x/text v0.43.0"
	"golang.org/x/text v0.43.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v1 v1.0.0-20140924161607-9f9df34309c0/go.mod"
	"howett.net/plist v1.0.1"
	"howett.net/plist v1.0.1/go.mod"
)

go-module_set_globals

SRC_URI="https://github.com/kovidgoyal/kitty/releases/download/v0.50.0/kitty-0.50.0.tar.xz -> kitty-0.50.0.tar.xz
https://direct.funtoo.org/2b/08/75/2b0875da9cef2718b215467458021a498c097baef04fcf40ae769f6f903a26a15e8c01ed4578874b8ebc1579ecf266ce5406001b53935059a5167dedd01b531b -> kitty-0.50.0-funtoo-go-bundle-ea33fdb2bbf73610235bd4b43f76e695b08a819f7668e1a5d66fd59883d0b7623269f106f4bb153fe51a6e187588a0196d6712abd930458f9ab143c2fb94c57b.tar.gz"
KEYWORDS="next"

DESCRIPTION="If you live in the terminal, kitty is made for you! Cross-platform, fast, feature-rich, GPU based."
HOMEPAGE="https://github.com/kovidgoyal/kitty"

LICENSE="GPL-3"
SLOT="0"
IUSE="debug wayland"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	~x11-terms/kitty-shell-integration-${PV}
	~x11-terms/kitty-terminfo-${PV}
	media-libs/fontconfig
	media-libs/freetype:2
	>=media-libs/harfbuzz-1.5.0:=
	media-libs/lcms
	media-libs/libcanberra
	media-libs/libpng:0=
	sys-apps/dbus
	sys-libs/zlib
	x11-libs/libxcb[xkb]
	x11-libs/libXcursor
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libxkbcommon[X]
	x11-libs/libXrandr
	net-libs/librsync
	dev-libs/xxhash
	wayland? (
		dev-libs/wayland
		>=dev-libs/wayland-protocols-1.17
	)
	$(python_gen_cond_dep 'dev-python/importlib_resources[${PYTHON_USEDEP}]' python3_6)
"

DEPEND="${RDEPEND}
	media-libs/mesa[X]
	sys-libs/ncurses
	amd64? ( dev-libs/simde )
	arm64? ( dev-libs/simde )
"

BDEPEND="
	virtual/pkgconfig
"

PATCHES=(
)

QA_FLAGS_IGNORED="usr/bin/kitten" # written in Go

src_prepare() {
	default

	sed -i -e "/build_terminfo =/,+4d" setup.py # remove terminfo
	sed -i "s/'launcher'/'..\/linux-package\/bin'/" kitty/constants.py # tests

	# flags
	sed -i \
		-e "s/optimize =.*/optimize = ''/g" \
		-e "s/ + ('' if debug else ' -O3')//g" \
		-e "s/ -Werror / /g" \
		-e "s/cflags.append('-O3')/pass/g" \
		-e "s/ -pipe //g" \
		setup.py

	# disable wayland as required
	if ! use wayland; then
		sed -i "/'x11 wayland'/s/ wayland//" setup.py || die
	fi

	# respect doc dir
	sed -i "/htmldir =/s/appname/'${PF}'/" setup.py || die

	tc-export CC
}

src_compile() {
	# workaround simde bug with -mxop (Gentoo Bug: https://bugs.gentoo.org/926959)
	append-cppflags -DSIMDE_X86_XOP_NO_NATIVE=1

	"${EPYTHON}" setup.py \
		--verbose $(usex debug --debug "") \
		--libdir-name $(get_libdir) \
		--shell-integration="enabled no-rc" \
		--update-check-interval=0 \
		linux-package || die "Failed to compile kitty."

	rm -r linux-package/$(get_libdir)/kitty/terminfo || die
}

src_test() {
	export KITTY_CONFIG_DIRECTORY=${T}
	"${EPYTHON}" test.py || die
}

src_install() {
	insinto /usr

	doins -r linux-package/*
	dobin linux-package/bin/kitty

	fperms +x /usr/$(get_libdir)/kitty/shell-integration/ssh/kitty
	fperms +x /usr/bin/kitten

	python_fix_shebang "${ED}"
}

pkg_postinst() {
	xdg_icon_cache_update
	elog "Displaying images in the terminal" virtual/imagemagick-tools
}

pkg_postrm() {
	xdg_icon_cache_update
}