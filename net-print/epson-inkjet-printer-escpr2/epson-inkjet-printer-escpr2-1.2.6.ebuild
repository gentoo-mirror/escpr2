# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DSC_F="dsc/f/03/00/15/03/68/096d68b8c6f18964a4b646bdd35d61635c647fda"
MY_PV="${PV}-1"

DESCRIPTION="Epson ESC/P-R 2 generic Inkjet Printer Driver"
HOMEPAGE="https://support.epson.net/linux/Printer/LSB_distribution_pages/en/escpr2.php"
# to get the (link for the) .tar.gz sources, which are identical to the .rpm sources for x86, one must "click here" for the "source package for arm CPU"
# the sources are often (delayed) also available from the EPSON driver download page: https://download.ebz.epson.net/dsc/search/01/search/?OSC=LX
SRC_URI="https://download3.ebz.epson.net/${DSC_F}/${PN}-${MY_PV}.tar.gz"
LICENSE="EPSON-EULA LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86 arm arm64"
IUSE="escprlib"

RESTRICT="mirror"
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

pkg_postinst() {
        elog "The online user manual is available at:"
        elog "    https://download.ebz.epson.net/man/linux/escpr2.html"
}
