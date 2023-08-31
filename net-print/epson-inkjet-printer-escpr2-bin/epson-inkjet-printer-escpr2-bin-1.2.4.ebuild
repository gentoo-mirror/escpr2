# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit rpm

<<<<<<< HEAD
DSC_amd64="f/03/00/14/75/73/5d4134f621ecb4836d84ac877ec08310a0b87ca9"
SVR="-1"

DESCRIPTION="Epson ESC/P-R 2 generic Inkjet Printer Driver binary package"
HOMEPAGE="https://download.ebz.epson.net/dsc/search/01/search/?OSC=LX"
SRC_URI="https://download3.ebz.epson.net/dsc/${DSC_amd64}/epson-inkjet-printer-escpr2-${PV}${SVR}.x86_64.rpm"
=======
DSC_F="dsc/f/03/00/14/85/37/e2c9cfe0c7cfbb8cb3d440938be64bdad965d64b"
MY_PN="epson-inkjet-printer-escpr2"
MY_PV="${PV}-1"

DESCRIPTION="Epson ESC/P-R 2 generic Inkjet Printer Driver binary package"
HOMEPAGE="https://support.epson.net/linux/Printer/LSB_distribution_pages/en/escpr2.php"
# the sources are often (delayed) also available from the EPSON driver download page: https://download.ebz.epson.net/dsc/search/01/search/?OSC=LX
SRC_URI="https://download3.ebz.epson.net/${DSC_F}/${MY_PN}-${MY_PV}.x86_64.rpm"
>>>>>>> 44d5b89 (version bump to 1.2.4 (2023-08-25) and reworked ebuild also for binary ebuild)
LICENSE="EPSON-EULA LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="mirror"
RDEPEND="net-print/cups
         !net-print/epson-inkjet-printer-escpr2"
DEPEND="${RDEPEND}"

<<<<<<< HEAD
S="${WORKDIR}/opt/epson-inkjet-printer-escpr2"

src_unpack() {
    rpm_src_unpack epson-inkjet-printer-escpr2-${PV}-1lsb3.2.x86_64.rpm
=======
S="${WORKDIR}/opt/${MY_PN}"

src_unpack() {
    rpm_src_unpack ${MY_PN}-${MY_PV}.x86_64.rpm
>>>>>>> 44d5b89 (version bump to 1.2.4 (2023-08-25) and reworked ebuild also for binary ebuild)
    cd ${S}
}

src_install() {
# libraries
    dolib.so lib64/libescpr2.so.1.0.0 lib64/libescpr2.so.1.0.0 lib64/libescpr2.so.1.0.0
# cups executables
    exeinto /opt/epson-inkjet-printer-escpr2/cups/lib/filter
    doexe cups/lib/filter/epson-escpr-wrapper2 cups/lib/filter/epson-escpr2
# docs
    dodoc doc/*
# ppds
<<<<<<< HEAD
    insinto /usr/share/ppd/epson-inkjet-printer-escpr2/
=======
    insinto /usr/share/ppd/${MY_PN}/
>>>>>>> 44d5b89 (version bump to 1.2.4 (2023-08-25) and reworked ebuild also for binary ebuild)
    doins ppds/Epson/*
}
