# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools desktop eutils flag-o-matic multilib pam

DESCRIPTION="A modular screen saver and locker for the X Window System"
HOMEPAGE="https://www.jwz.org/xscreensaver/"
SRC_URI="https://jwz.org/xscreensaver/xscreensaver-6.03.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"
IUSE="caps +gdk-pixbuf +gtk jpeg +locking new-login offensive +opengl pam +perl selinux suid xinerama"
REQUIRED_USE="
	gdk-pixbuf? ( gtk )
"

COMMON_DEPEND="
	>=gnome-base/libglade-2
	dev-libs/libxml2
	media-libs/netpbm
	x11-apps/appres
	x11-apps/xwininfo
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXft
	x11-libs/libXi
	x11-libs/libXmu
	x11-libs/libXrandr
	x11-libs/libXt
	x11-libs/libXxf86vm
	caps? ( sys-libs/libcap )
	gdk-pixbuf? (
		|| (
			<x11-libs/gdk-pixbuf-2.42:2
			(
				x11-libs/gdk-pixbuf-xlib
				>=x11-libs/gdk-pixbuf-2.42.0:2
			)
		)
	)
	gtk? ( x11-libs/gtk+:2 )
	jpeg? ( virtual/jpeg:0 )
	opengl? (
		virtual/glu
		virtual/opengl
	)
	pam? ( sys-libs/pam )
	xinerama? ( x11-libs/libXinerama )
"
# For USE="perl" see output of `qlist xscreensaver | grep bin | xargs grep '::'`
RDEPEND="
	${COMMON_DEPEND}
	perl? (
		dev-lang/perl
		dev-perl/libwww-perl
		virtual/perl-Digest-MD5
	)
	selinux? ( sec-policy/selinux-xscreensaver )
	x11-base/xorg-x11[fonts]
"
DEPEND="
	${COMMON_DEPEND}
	dev-util/intltool
	sys-devel/bc
	sys-devel/gettext
	virtual/pkgconfig
	x11-base/xorg-proto
"

src_prepare() {
	default

	sed -e 's:/usr/share/fonts/X11:/usr/share/fonts /usr/share/fonts/X11:' \
    	-i configure.ac || die

	if ! use offensive; then
		sed -i \
			-e '/boobies/d;/boobs/d;/cock/d;/pussy/d;/viagra/d;/vibrator/d' \
			hacks/barcode.c || die
		sed -i \
			-e 's|erect penis|shuffle board|g' \
			-e 's|flaccid penis|flaccid anchor|g' \
			-e 's|vagina|engagement ring|g' \
			-e 's|Penis|Shuttle|g' \
			hacks/glx/glsnake.c || break
	fi

	eapply_user
	eautoconf
	eautoheader
}

src_configure() {
	if use ppc || use ppc64; then
		filter-flags -maltivec -mabi=altivec
		append-flags -U__VEC__
	fi

	unset BC_ENV_ARGS #24568
	export RPM_PACKAGE_VERSION=no #368025

	econf \
		$(use_enable locking) \
		$(use_with caps setcap-hacks) \
		$(use_with gdk-pixbuf pixbuf) \
		$(use_with gtk) \
		$(use_with jpeg) \
		$(use_with new-login login-manager) \
		$(use_with opengl gl) \
		$(use_with pam) \
		$(use_with suid setuid-hacks) \
		$(use_with xinerama xinerama-ext) \
		--with-configdir="${EPREFIX}"/usr/share/${PN}/config \
		--with-dpms-ext \
		--with-hackdir="${EPREFIX}"/usr/$(get_libdir)/misc/${PN} \
		--with-proc-interrupts \
		--with-randr-ext \
		--with-text-file="${EPREFIX}"/etc/gentoo-release \
		--with-x-app-defaults="${EPREFIX}"/usr/share/X11/app-defaults \
		--with-xdbe-ext \
		--with-xf86gamma-ext \
		--with-xf86vmode-ext \
		--with-xinput-ext \
		--with-xshm-ext \
		--without-gle \
		--without-kerberos \
		--without-motif \
		--x-includes="${EPREFIX}"/usr/include \
		--x-libraries="${EPREFIX}"/usr/$(get_libdir)
}

src_install() {
	emake install_prefix="${D}" install

	dodoc README{,.hacking}

	use pam && fperms 755 /usr/bin/${PN}
	pamd_mimic_system ${PN} auth

	rm -f "${ED}"/usr/share/${PN}/config/{electricsheep,fireflies}.xml
}