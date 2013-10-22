# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="ManKai Common Lisp (MKCL) is a modern implementation of the Common Lisp language originated in ECL"
HOMEPAGE="http://common-lisp.net/project/mkcl/"
SRC_URI="http://common-lisp.net/project/mkcl/releases/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug gengc threads +unicode X"

RDEPEND="dev-libs/gmp
		virtual/libffi"
DEPEND="${RDEPEND}
		app-text/texi2html"
#PDEPEND="dev-lisp/gentoo-init"

S="${WORKDIR}/${P}/"

src_configure() {
	econf \
		--with-system-gmp \
		--enable-longdouble \
		--enable-c99complex \
		$(use_enable gengc) \
		$(use_enable debug) \
		$(use_enable threads) \
		$(use_with threads __thread) \
		$(use_enable unicode) \
		$(use_with X x) \
		$(use_with X clx)
}

src_compile() {
	#parallel fails because of ./dpp
	emake -j1 || die
}

src_install() {
	einstall mkcldir="${ED}/usr/$(get_libdir)/${P}" || die
}
