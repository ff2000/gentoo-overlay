# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} )
inherit python-single-r1 autotools eutils git-r3

MY_PN="${PN/d/D}"

DESCRIPTION="An implementation of the MPRIS 2 interface as a client for MPD"
HOMEPAGE="http://github.com/eonpatapon/mpDris2"
SRC_URI="" # http://ayeon.org/projects/${MY_PN}/${MY_PN}-${PV}.tar.bz2"
EGIT_REPO_URI="git://github.com/eonpatapon/mpDris2.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="${PYTHON_DEPS}
		dev-python/dbus-python[${PYTHON_USEDEP}]
		dev-python/pygobject:3[${PYTHON_USEDEP}]
		dev-python/python-mpd[${PYTHON_USEDEP}]"

src_prepare() {
	eautoreconf
}

src_install() {
	emake install DESTDIR="${D}" || die "Failed to install"
}
