# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit rpm

DSC_F="dsc/f/03/00/16/00/22/fc41e57d21109cb444d6dc7f201b4cb72d71389b"
MY_PN="epson-inkjet-printer-escpr2"
MY_PV="${PV}-1"

DESCRIPTION="Epson ESC/P-R 2 generic Inkjet Printer Driver binary package"
HOMEPAGE="https://support.epson.net/linux/Printer/LSB_distribution_pages/en/escpr2.php"
# the sources are often (delayed) also available from the EPSON driver download page: https://download.ebz.epson.net/dsc/search/01/search/?OSC=LX
SRC_URI="https://download3.ebz.epson.net/${DSC_F}/${MY_PN}-${MY_PV}.x86_64.rpm"
LICENSE="EPSON-EULA LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="mirror"
RDEPEND="net-print/cups
         !net-print/epson-inkjet-printer-escpr2"
DEPEND="${RDEPEND}"

S="${WORKDIR}/opt/${MY_PN}"

src_unpack() {
    rpm_src_unpack ${MY_PN}-${MY_PV}.x86_64.rpm
    cd ${S}
}

src_install() {
# libraries
    dolib.so lib64/libescpr2.so.1.0.0 lib64/libescpr2.so.1.0.0 lib64/libescpr2.so.1.0.0
# cups executables
    exeinto /opt/${MY_PN}/cups/lib/filter
    doexe cups/lib/filter/epson-escpr-wrapper2 cups/lib/filter/epson-escpr2
# docs
    dodoc doc/*
# ppds
    insinto /usr/share/ppd/${MY_PN}/
    doins ppds/Epson/*
}

pkg_postinst() {
        elog "The online user manual is available at:"
        elog "    https://download.ebz.epson.net/man/linux/escpr2.html"
}
