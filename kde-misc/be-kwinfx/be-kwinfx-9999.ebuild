# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
KDE_MINIMAL="4.9"
KDE_REQUIRED="always"
inherit kde4-base git-2

DESCRIPTION="Effects for KWin."
HOMEPAGE="http://sourceforge.net/projects/bekwinfx/?source=navbar"
EGIT_REPO_URI="clone git://git.code.sf.net/p/bekwinfx/code"

LICENSE="GPL"
SLOT="0"
KEYWORDS="-*"
IUSE="+animated clock distorted faded reflected"
# distorted reflected : currently broken

DEPEND="
		x11-libs/qt-core:4
		x11-libs/qt-gui:4
		|| ( kde-base/kwin[gles] kde-base/kwin[opengl] )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build animated ANIMATED)
		$(cmake-utils_use_build clock CLOCK)
		$(cmake-utils_use_build distorted DISTORTED)
		$(cmake-utils_use_build faded FADED)
		$(cmake-utils_use_build reflected REFLECTED)
	)
	kde4-base_src_configure
}
