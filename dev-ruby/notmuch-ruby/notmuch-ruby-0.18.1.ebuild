# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21"

inherit ruby-ng

DESCRIPTION="Ruby bindings for notmuch"
HOMEPAGE="http://www.notmuch.org"
SRC_URI="${HOMEPAGE%/}/releases/${P/-ruby/}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=net-mail/notmuch-${PV}"
RDEPEND="${DEPEND}"
PDEPEND="dev-ruby/mail"

RUBY_S="${P/-ruby/}"

all_ruby_unpack() {
	unpack ${A}
}

each_ruby_prepare() {
	epatch "${FILESDIR}/${P}-build_standalone.patch"
}

each_ruby_configure() {
	# pushd bindings/ruby
	${RUBY} -Cbindings/ruby extconf.rb || die "ruby config failed"
}

each_ruby_compile() {
	# pushd bindings/ruby
	emake -Cbindings/ruby || die "ruby compile failed"
}

each_ruby_install() {
	# pushd bindings/ruby
	emake -Cbindings/ruby DESTDIR="${D}" install || die "ruby install failed"
}
