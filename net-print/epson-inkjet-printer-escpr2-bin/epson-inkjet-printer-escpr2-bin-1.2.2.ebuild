# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit rpm

DSC_amd64="f/03/00/14/74/04/29c580c8e0949f92c2959300325a3519438c95f8"

DESCRIPTION="Epson ESC/P-R 2 generic Inkjet Printer Driver binary package"
HOMEPAGE="https://download.ebz.epson.net/dsc/search/01/search/?OSC=LX"
SRC_URI="amd64? ( https://download3.ebz.epson.net/dsc/${DSC_amd64}/epson-inkjet-printer-escpr2-${PV}-1.x86_64.rpm )"
LICENSE="EPSON-EULA LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="mirror"
RDEPEND="net-print/cups
         !net-print/epson-inkjet-printer-escpr2"
DEPEND="${RDEPEND}"

S="${WORKDIR}/opt/epson-inkjet-printer-escpr2"

src_unpack() {
    if use amd64; then
    rpm_src_unpack epson-inkjet-printer-escpr2-${PV}-1lsb3.2.x86_64.rpm
    fi
    cd ${S}
}

src_install() {
# libraries
    if use x86; then 
        dolib.so lib/libescpr2.so.1.0.0 lib/libescpr2.so.1.0.0 lib/libescpr2.so.1.0.0
    elif use amd64; then
        dolib.so lib64/libescpr2.so.1.0.0 lib64/libescpr2.so.1.0.0 lib64/libescpr2.so.1.0.0
    fi
# cups executables
    exeinto /opt/epson-inkjet-printer-escpr2/cups/lib/filter
    doexe cups/lib/filter/epson-escpr-wrapper2 cups/lib/filter/epson-escpr2
# docs
    dodoc doc/*
# ppds
    insinto /usr/share/ppd/epson-inkjet-printer-escpr2/
    doins ppds/Epson/*
}
