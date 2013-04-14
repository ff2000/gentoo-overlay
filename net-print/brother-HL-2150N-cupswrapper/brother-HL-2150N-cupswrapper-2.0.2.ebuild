# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit rpm

DESCRIPTION="Brother HL-2150N CUPS wrapper"
HOMEPAGE="http://solutions.brother.com/linux/en_us/index.html"
SRC_URI="http://pub.brother.com/pub/com/bsc/linux/dlf/cupswrapperHL2150N-2.0.2-1.i386.rpm"
#SRC_URI="http://www.brother.com/pub/bsc/linux/dlf/dcp145ccupswrapper-1.1.2-2.i386.rpm"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=">=net-print/brother-HL-2150N-lpr-2.0.2
		amd64? ( app-emulation/emul-linux-x86-compat )"
RDEPEND="${DEPEND}"


src_unpack () {
	rpm_src_unpack ${A} || die "Cannot unpack"
	#epatch "${FILESDIR}/adjust_servicies_link.patch" || die "Cannot patch"
}

src_install(){
	cp * -vr ${D}
}

pkg_postinst() {
	elog "Now run the wrapper located in:"
	elog "/usr/local/Brother/Printer/dcp145c/cupswrapper/cupswrapperdcp145c"
}
