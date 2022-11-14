#!/bin/sh
#
# Run as: sh scripts/list-ppds-from-tar.sh
#
PV=`ls -v net-print/epson-inkjet-printer-escpr2/*.ebuild | tail -n 1 | sed 's/^net-print\/epson-inkjet-printer-escpr2\/epson-inkjet-printer-escpr2-//' | sed 's/.ebuild$//'`
TMPDIR="/tmp"
TARGZ_FILE="${TMPDIR}/epson-inkjet-printer-escpr2-${PV}.tar.gz"
OUTFILE="latest-ppd-list.txt"
source net-print/epson-inkjet-printer-escpr2/epson-inkjet-printer-escpr2-${PV}.ebuild
wget -O "${TARGZ_FILE}" "${SRC_URI}"
cat << EOF > ${OUTFILE}
List of PostScript Printer Description files (PPDs) in epson-inkjet-printer-escpr2-${PV}:

EOF
tar -ztf "$TARGZ_FILE" --wildcards '*.ppd' | sed 's/epson-inkjet-printer-escpr2-.*\/ppd\///' | sed 's/-epson-escpr2-en.ppd//' | tr '-' ' ' | tr '_' ' ' | sort -h - >> ${OUTFILE}
rm "${TARGZ_FILE}"
