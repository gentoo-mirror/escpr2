# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DSC_src="f/03/00/14/47/09/7b92a3e5464e73253129a01790b9fc95bdbbca5c"

DESCRIPTION="Epson ESC/P-R 2 generic Inkjet Printer Driver"
HOMEPAGE="https://download.ebz.epson.net/dsc/search/01/search/?OSC=LX"
SRC_URI="https://download3.ebz.epson.net/dsc/${DSC_src}/epson-inkjet-printer-escpr2-${PV}.tar.gz"
LICENSE="EPSON-EULA LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86 ~arm ~arm64"
IUSE="escprlib"

RESTRICT="mirror"
RDEPEND="net-print/cups
         !net-print/epson-inkjet-printer-escpr2-bin"
DEPEND="${RDEPEND}"

PATCHES=(
    # Shamelessly copied from:
    # https://aur.archlinux.org/packages/epson-inkjet-printer-escpr2/
    # Patch URL: https://aur.archlinux.org/cgit/aur.git/commit/?h=epson-inkjet-printer-escpr2&id=f25541048d4817c9f67ee97ec14e0105d89a9fee
    "${FILESDIR}/gcc-no-implicit-function-declaration-1.1.15.patch"
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

pkg_postinst() {
        elog "The online user manual is available at:"
        elog "    https://download.ebz.epson.net/man/linux/escpr2.html"
}
