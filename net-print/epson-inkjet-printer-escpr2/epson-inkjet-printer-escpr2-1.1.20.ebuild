# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DSC_src="f/03/00/11/94/32/a90c274606469434dd2ebc035676f8e1262f4f82"

DESCRIPTION="Epson Inkjet Printer Driver (ESC/P-R) 2"
HOMEPAGE="http://download.ebz.epson.net/dsc/search/01/search/?OSC=LX"
SRC_URI="https://download3.ebz.epson.net/dsc/${DSC_src}/epson-inkjet-printer-escpr2-${PV}.tar.gz"
LICENSE="EPSON-EULA LGPL-2.1"
SLOT="0"
RESTRICT="mirror"
KEYWORDS="amd64 x86 ~arm ~arm64"
IUSE="escprlib"

RDEPEND="net-print/cups
         !net-print/epson-inkjet-printer-escpr2-bin"
DEPEND="${RDEPEND}"

PATCHES=(
    # Shamelessly copied from:
    # https://aur.archlinux.org/packages/epson-inkjet-printer-escpr2/
    # Patch URL: https://aur.archlinux.org/cgit/aur.git/tree/bug_x86_64.patch?h=epson-inkjet-printer-escpr2
    "${FILESDIR}/bug_x86_64.patch"
)

src_configure() {
    econf --disable-shared

    # Makefile calls ls to generate a file list which is included in Makefile.am
    # Set the collation to C to avoid automake being called automatically
    unset LC_ALL
    export LC_COLLATE=C
}

src_install() {
    emake -C ppd DESTDIR="${D}" install
    if use escprlib ; then
        emake -C escprlib DESTDIR="${D}" install
    fi
    emake -C src DESTDIR="${D}" install
    einstalldocs
}
