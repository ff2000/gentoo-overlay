# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bempc/bempc-0.11.ebuild,v 1.2 2013/03/02 21:53:25 hwoarang Exp $

EAPI=4
LANGS="cs de"
inherit qmake-utils fdo-mime

DESCRIPTION="Qt5 MPD client with experimental UI"
HOMEPAGE="http://qt-apps.org/content/show.php?content=137091"

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="git://git.code.sf.net/p/be-mpc/code"
else
	KEYWORDS="~amd64 ~x86"
	SNAPSHOT_HASH=""
	SRC_URI="http://sourceforge.net/code-snapshots/git/b/be/be-mpc/code.git/be-mpc-code-${SNAPSHOT_HASH}.zip -> ${P}.zip"
	S="${WORKDIR}/be-mpc-code-${SNAPSHOT_HASH}"
fi


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libmpdclient
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtconcurrent:5
	dev-qt/qtnetwork:5"
RDEPEND="${DEPEND}"

src_prepare() {
	local INSTALLED_LANGS= LANG=

	# Install on live fs should be done by portage itself
	sed -ie 's/postinstall/#postinstall/g' be.mpc.pro

	# Install only chosen locales
	for LANG in ${LINGUAS}; do
		if has ${LANG} ${LANGS}; then
			INSTALLED_LANGS="${INSTALLED_LANGS} be.mpc_${LANG}.qm"
		fi
	done
	sed -ie "s/i18n.files += be.mpc_cs.qm be.mpc_de.qm/i18n.files += ${INSTALLED_LANGS}/" be.mpc.pro

	# Fix invalid desktop file
	sed -ie 's/Categories=Application;Qt;Audio;/Categories=Qt;AudioVideo;Audio;/' be.mpc.desktop
}

src_configure() {
	eqmake5 be.mpc.pro
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "install failed"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
