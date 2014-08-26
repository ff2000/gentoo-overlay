# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

if [[ ${PV} == "9999" ]]; then
	VCS_ECLASS=git-2
	EGIT_REPO_URI="git://github.com/QupZilla/${PN}.git"
	KEYWORDS=""
else
	VCS_ECLASS=vcs-snapshot
	MY_P="QupZilla-${PV}"
	SRC_URI="mirror://github/QupZilla/${PN}/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${MY_P}
fi

PLOCALES="ca_ES cs_CZ de_DE el_GR es_ES es_VE fa_IR fr_FR hu_HU id_ID it_IT ja_JP
ka_GE nl_NL pl_PL pt_BR pt_PT ro_RO ru_RU sk_SK sr sv_SE uk_UA
zh_CN zh_TW"

inherit l10n multilib qmake-utils qt4-r2 ${VCS_ECLASS}

DESCRIPTION="Qt WebKit web browser"
HOMEPAGE="http://www.qupzilla.com/"

LICENSE="GPL-3"
SLOT="0"
IUSE="dbus debug kde nonblockdialogs qt5"

DEPEND="
	!qt5? (
		>=dev-qt/qtcore-4.7:4
		>=dev-qt/qtgui-4.7:4
		>=dev-qt/qtscript-4.7:4
		>=dev-qt/qtsql-4.7:4
		>=dev-qt/qtwebkit-4.7:4
		dbus? ( >=dev-qt/qtdbus-4.7:4 )
	)
		qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/linguist:5
		dev-qt/linguist-tools:5
		dev-qt/qtconcurrent:5
		dev-qt/qtprintsupport:5
		dev-qt/qtscript:5
		dev-qt/qtsql:5
		dev-qt/qtwebkit:5[widgets]
		dbus? ( dev-qt/qtdbus:5 )
	)
	"
RDEPEND="${DEPEND}"

DOCS="AUTHORS BUILDING CHANGELOG FAQ README.md"

src_prepare() {
	# remove outdated copies of localizations:
	rm -rf bin/locale || die
	epatch_user
}

src_configure() {
	# see BUILDING document for explanation of options
	export QUPZILLA_PREFIX=${EPREFIX}/usr/
	export USE_LIBPATH=${QUPZILLA_PREFIX}$(get_libdir)
	export DISABLE_DBUS=$(use dbus && echo false || echo true)
	export KDE=$(use kde && echo true || echo false) # in future this will enable nepomuk integration
	export NONBLOCK_JS_DIALOGS=$(use nonblockdialogs && echo true || echo false)
	if use qt5; then
		eqmake5
	else
		eqmake4
	fi
}

src_install() {
	# NOTE: this seems to work even for qt5-build
	qt4-r2_src_install
	l10n_for_each_disabled_locale_do rm_loc
}

rm_loc() {
	rm "${D}"/usr/share/${PN}/locale/${1}.qm || die
}
