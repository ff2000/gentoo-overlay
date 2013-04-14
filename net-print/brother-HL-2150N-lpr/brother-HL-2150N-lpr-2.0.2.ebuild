# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit rpm

DESCRIPTION="Brother DCP-145C LPR print drivers"
HOMEPAGE="http://solutions.brother.com/linux/en_us/index.html"
SRC_URI="http://pub.brother.com/pub/com/bsc/linux/dlf/brhl2150nlpr-2.0.2-1.i386.rpm"
#SRC_URI="http://www.brother.com/pub/bsc/linux/dlf/dcp145clpr-1.1.2-2.i386.rpm"

LICENSE="Brother"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="net-print/cups
		amd64? ( app-emulation/emul-linux-x86-compat )"
RDEPEND="${DEPEND}"

src_unpack () {
	rpm_src_unpack ${A}
}

src_install(){
	cp * -vr ${D}
}

