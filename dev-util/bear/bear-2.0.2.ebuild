# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} )
inherit cmake-utils python-single-r1

DESCRIPTION="Build EAR: tool for generating llvm compilation databases"
HOMEPAGE="https://github.com/rizsotto/Bear"
if [[ ${PV} == 9999* ]] ; then
	KEYWORDS=""
	EGIT_REPO_URI="git://github.com/rizsotto/Bear.git"
	inherit git-r3
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/rizsotto/Bear/archive/${PV}.tar.gz -> ${P}.tar.gz"
	MY_PN="${PN/b/B}"
	S="${WORKDIR}/${MY_PN}-${PV}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}"
