# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit kde4-base

DESCRIPTION="KDE plasmoid to integrate Activities, Virtual Desktops and Tasks
Functionalities from Plasma Desktop in just one component."
HOMEPAGE="http://www.kde-look.org/content/show.php/WorkFlow+Plasmoid?content=147428"
MY_P=${P/plasma/plasmoid}
SRC_URI="http://www.opentoolsandspace.org/Art/WorkFlow/0.4.x/${MY_P}.tar.gz"

S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"

IUSE=""

DEPEND="
		$(add_kdebase_dep kactivities)
"
RDEPEND="${DEPEND}"


pkg_postinst() {
	einfo "There are kwin scripts to interact with this plasmoid:"
	einfo "http://kde-look.org/content/show.php/WorkFlow+KWin+Script?content=157726"
	einfo "http://kde-look.org/content/show.php/WorkFlow+KWin+Script+Launcher?content=157728"
}
