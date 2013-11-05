# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby19 ruby20"

inherit git-2 ruby-ng

DESCRIPTION="Ruby bindings for notmuch"
HOMEPAGE="http://www.notmuch.org"
EGIT_REPO_URI="git://git.notmuchmail.org/git/notmuch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="=net-mail/notmuch-${PV}
		dev-lang/ruby:1.9"
RDEPEND="${DEPEND}"
PDEPEND="dev-ruby/mail"

all_ruby_unpack() {
	git-2_src_unpack
}

each_ruby_prepare() {
	epatch "${FILESDIR}/build_standalone.patch"
}

each_ruby_configure() {
	pushd bindings/ruby
	${RUBY} extconf.rb || die "ruby config failed"
}

each_ruby_compile() {
	pushd bindings/ruby
	emake || die "ruby compile failed"
}

each_ruby_install() {
	pushd bindings/ruby
	emake DESTDIR="${D}" install || die "ruby install failed"
}
