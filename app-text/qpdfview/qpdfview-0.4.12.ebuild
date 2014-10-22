# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/qpdfview/qpdfview-0.4.6.ebuild,v 1.1 2013/10/21 03:46:37 yngwin Exp $

EAPI=5

PLOCALES="ast az bg bs ca cs da de el en_GB eo es eu fi fr gl he hr id it kk ky ms my pl pt pt_BR ro ru sk tr ug uk zh_CN"
inherit l10n multilib qmake-utils base

DESCRIPTION="A tabbed document viewer"
HOMEPAGE="http://launchpad.net/qpdfview"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="cups dbus djvu mupdf +pdf postscript sqlite +svg synctex"

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtprintsupport:5
	dev-qt/linguist:5
	cups? ( net-print/cups )
	dbus? ( dev-qt/qtdbus:5 )
	djvu? ( app-text/djvu )
	mupdf? ( app-text/mupdf )
	pdf? ( app-text/poppler[qt5] )
	postscript? ( app-text/libspectre )
	sqlite? ( dev-qt/qtsql:5[sqlite] )
	svg? ( dev-qt/qtsvg:5 )
	!svg? ( virtual/freedesktop-icon-theme )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( CHANGES CONTRIBUTORS README TODO )

prepare_locale() {
	/usr/$(get_libdir)/qt5/bin/lrelease "translations/${PN}_${1}.ts" || die "preparing ${1} locale failed"
}

rm_help() {
	if [[ -e "miscellaneous/help_${1}.html" ]]; then
		rm "miscellaneous/help_${1}.html" || die "removing extraneous help files failed"
	fi
}

PATCHES="${FILESDIR}/${P}-no_sql.patch"

src_prepare() {
	#sed -i "s/-lmupdf-js-none//" fitz-plugin.pro ||
	#	die "sed fitz-plugin failed"

	l10n_find_plocales_changes "translations" "${PN}_" '.ts'
	l10n_for_each_locale_do prepare_locale
	l10n_for_each_disabled_locale_do rm_help

	base_src_prepare
}

src_configure() {
	local config i

	for i in cups dbus pdf djvu svg synctex ; do
		if ! use ${i} ; then
			config+=" without_${i}"
		fi
	done

	if use mupdf ; then
		config+=" with_fitz without_pdf"
	fi

	if ! use sqlite ; then
		config+=" without_sql"
	fi

	if ! use postscript ; then
		config+=" without_ps"
	fi

	eqmake5 CONFIG+="${config}" PLUGIN_INSTALL_PATH="/usr/$(get_libdir)/${PN}" qpdfview.pro
}

src_install() {
	base_src_install INSTALL_ROOT="${D}"
}
