# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit rpm

DSC_x86="f/03/00/11/87/06/964efa824353a7d9dda72e28c3378424e5526f2a"
DSC_amd64="f/03/00/11/87/06/6b44055cdb3c2b9f6c78a280aabf37649310ab45"

DESCRIPTION="Epson Inkjet Printer Driver (ESC/P-R) 2 BINARY PACKAGE"
HOMEPAGE="http://download.ebz.epson.net/dsc/search/01/search/?OSC=LX"
SRC_URI="x86? ( https://download3.ebz.epson.net/dsc/${DSC_x86}/epson-inkjet-printer-escpr2-${PV}-1lsb3.2.i486.rpm )
         amd64? ( https://download3.ebz.epson.net/dsc/${DSC_amd64}/epson-inkjet-printer-escpr2-${PV}-1lsb3.2.x86_64.rpm )"

LICENSE="EPSON-EULA LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="net-print/cups
         sys-libs/liblsb-compat:3
         !net-print/epson-inkjet-printer-escpr2"
DEPEND="${RDEPEND}"

S="${WORKDIR}/opt/epson-inkjet-printer-escpr2"

src_unpack() {
    if use x86; then
    rpm_src_unpack epson-inkjet-printer-escpr2-${PV}-1lsb3.2.i486.rpm
    elif use amd64; then
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
