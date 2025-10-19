# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )

inherit bash-completion-r1 cargo desktop python-any-r1

DESCRIPTION="A cross-platform, OpenGL terminal emulator."
HOMEPAGE="https://github.com/alacritty/alacritty"
SRC_URI="https://github.com/alacritty/alacritty/tarball/b3f2aa1d1a3e38ac68604287186b5803af35f399 -> alacritty-0.16.0-b3f2aa1.tar.gz
https://direct.funtoo.org/cf/60/2b/cf602b8f7186eb0c5c3815576606d20de7137c57f73d8f0ceec5804cd269e38d30b490e7c967c38ccbfac810933492e7b296ad97f2874172bce387c31719e398 -> alacritty-0.16.0-funtoo-crates-bundle-c4841a322d1983d83fb8b6e88cf28fc5729fbca7aefd9f3bc02d256337c01df63787809aff2880dc9d386ae61cd1846f3c4ad2ebfa5778d8266afd2b7cae101e.tar.gz"

KEYWORDS="*"
LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions Boost-1.0 BSD BSD-2 CC0-1.0 FTL ISC MIT MPL-2.0 Unlicense WTFPL-2 ZLIB"
SLOT="0"
IUSE="wayland +X"

REQUIRED_USE="|| ( wayland X )"

DEPEND="${PYTHON_DEPS}"
BDEPEND="
	dev-util/cmake
	virtual/rust
"

COMMON_DEPEND="
	media-libs/fontconfig:=
	media-libs/freetype:2
	X? ( x11-libs/libxcb:=[xkb] )
"

RDEPEND="${COMMON_DEPEND}
	media-libs/mesa[X?,wayland?]
	sys-libs/zlib
	sys-libs/ncurses:0
	wayland? ( dev-libs/wayland )
	X? (
		x11-libs/libXcursor
		x11-libs/libXi
		x11-libs/libXrandr
	)
"

QA_FLAGS_IGNORED="usr/bin/alacritty"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/alacritty-alacritty-* ${S} || die
}

src_configure() {
	local myfeatures=(
		$(usex X x11 '')
		$(usev wayland)
	)
	cargo_src_configure --no-default-features
}

src_compile() {
	cd alacritty || die
	cargo_src_compile
}

src_install() {
	cargo_src_install --path alacritty

	newman extra/man/alacritty.1.scd alacritty.1
	newman extra/man/alacritty.5.scd alacritty.5

	newbashcomp extra/completions/alacritty.bash alacritty

	insinto /usr/share/fish/vendor_completions.d/
	doins extra/completions/alacritty.fish

	insinto /usr/share/zsh/site-functions
	doins extra/completions/_alacritty

	domenu extra/linux/Alacritty.desktop
	newicon extra/logo/compat/alacritty-term.svg Alacritty.svg

	insinto /usr/share/metainfo
	doins extra/linux/org.alacritty.Alacritty.appdata.xml

	insinto /usr/share/alacritty/scripts
	doins -r scripts/*

	local DOCS=(
		CHANGELOG.md INSTALL.md README.md
		docs/{escape_support.md,features.md}
	)
	einstalldocs
}

src_test() {
	cd alacritty || die
	cargo_src_test
}