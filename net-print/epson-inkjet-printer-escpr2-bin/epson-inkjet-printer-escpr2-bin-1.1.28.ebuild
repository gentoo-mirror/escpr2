# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit rpm

DSC_x86="f/03/00/12/53/90/2340ec09e8b0d526f90d603a57219c2770a11a55"
DSC_amd64="f/03/00/12/53/90/f423b2c2518adf4c2a3c0008c8bfdec9ac76260b"

DESCRIPTION="Epson ESC/P-R 2 generic Inkjet Printer Driver BINARY PACKAGE"
HOMEPAGE="https://download.ebz.epson.net/dsc/search/01/search/?OSC=LX"
SRC_URI="x86? ( https://download3.ebz.epson.net/dsc/${DSC_x86}/epson-inkjet-printer-escpr2-${PV}-1lsb3.2.i486.rpm )
         amd64? ( https://download3.ebz.epson.net/dsc/${DSC_amd64}/epson-inkjet-printer-escpr2-${PV}-1lsb3.2.x86_64.rpm )"
LICENSE="EPSON-EULA LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RESTRICT="mirror"
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
