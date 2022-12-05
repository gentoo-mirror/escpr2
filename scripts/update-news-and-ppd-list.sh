#!/bin/sh
#
# Run as: sh scripts/update-news-and-ppd-list.sh
#
PVR=`ls -v net-print/epson-inkjet-printer-escpr2/*.ebuild | tail -n 1 | sed 's/^net-print\/epson-inkjet-printer-escpr2\/epson-inkjet-printer-escpr2-//' | sed 's/.ebuild$//'`
PV=`echo "$PVR" | cut -d '-' -f 1`
TMPDIR="/tmp"
TARGZ_FILE="${TMPDIR}/epson-inkjet-printer-escpr2-${PV}.tar.gz"
OUTFILE="SUPPORTED-PRINTERS"
source net-print/epson-inkjet-printer-escpr2/epson-inkjet-printer-escpr2-${PVR}.ebuild
DL_TARGZ=
test ! -e "${TARGZ_FILE}" && DL_TARGZ=1
test -n "${DL_TARGZ}" && wget -O "${TARGZ_FILE}" "${SRC_URI}"
tar -xzf "$TARGZ_FILE" --strip-components=1 --wildcards --no-anchored 'NEWS'
cat << EOF > ${OUTFILE}
List of PostScript Printer Description files (PPDs) in epson-inkjet-printer-escpr2-${PVR}:

EOF
tar -ztf "$TARGZ_FILE" --wildcards '*.ppd' | sed 's/epson-inkjet-printer-escpr2-.*\/ppd\///' | sed 's/-epson-escpr2-en.ppd//' | tr '-' ' ' | tr '_' ' ' | sort -V - >> ${OUTFILE}
test -n "${DL_TARGZ}" && rm "${TARGZ_FILE}"
