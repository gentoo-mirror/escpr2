# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DSC_src="f/03/00/11/97/69/19d4ffa45cc4f54bf2d873bc1258ecdcdd6671b7"

DESCRIPTION="Epson Inkjet Printer Utility"
HOMEPAGE="http://download.ebz.epson.net/dsc/search/01/search/?OSC=LX"
SRC_URI="https://download3.ebz.epson.net/dsc/${DSC_src}/epson-printer-utility_arm_source.zip"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86 ~arm ~arm64"
#IUSE="escprlib"

RESTRICT="mirror"
RDEPEND=""
DEPEND="${RDEPEND}"

src_extract() {
epson-printer-utility_arm_source.zip
  epson-printer-utility-arm-1.1.1.tar.gz

  
}

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
