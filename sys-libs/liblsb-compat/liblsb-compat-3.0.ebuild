# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Compatibility with lsb binary programs"

LICENSE="libstdc++"
SLOT="3"
KEYWORDS="x86 amd64"

RDEPEND="sys-libs/glibc:2.2"
DEPEND="${RDEPEND}"

S=${WORKDIR}

src_install() {
    if use amd64 ; then
	insinto /lib64
	dosym ld-linux-x86-64.so.2 /lib64/ld-lsb-x86-64.so.${SLOT}
    fi
    # both amd64 and x86:
    insinto /lib
    dosym ld-linux.so.2 /lib/ld-lsb.so.${SLOT}
}
