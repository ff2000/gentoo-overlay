# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
KDE_REQUIRED="always"
KDE_SCM="git"
CMAKE_USE_DIR="${S}/soliddiskscan"
inherit kde4-base

DESCRIPTION=""
HOMEPAGE=""
SRC_URI=""
EGIT_REPO_URI="https://github.com/sanya-m/solid-disk-prober.git"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=kde-base/kdelibs-4.10.0[udisks]"
RDEPEND="${DEPEND}"

pkg_postinst() {
	ewarn "If you reinstall ${CATEGORY}/${P}"
	ewarn "make sure to rebuild the patched kde-base/kdelibs"
	ewarn "as those two packages go hand in hand, and an updated"
	ewarn "${PN} quite sure needs updated patches for kdelibs!"
	ewarn "If you don't you will quite sure get trouble..."
}
