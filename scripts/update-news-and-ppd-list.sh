#!/bin/sh
#
# Run as: sh scripts/update-news-and-ppd-list.sh
#
PN="epson-inkjet-printer-escpr2"
PVR=`ls -v net-print/epson-inkjet-printer-escpr2/*.ebuild | tail -n 1 | sed 's/^net-print\/epson-inkjet-printer-escpr2\/epson-inkjet-printer-escpr2-//' | sed 's/.ebuild$//'`
PV=`echo "$PVR" | cut -d '-' -f 1`
MY_PV=$(source net-print/${PN}/${PN}-${PVR}.ebuild > /dev/null 2>&1 ; echo $MY_PV)
SRC_URI=$(source net-print/${PN}/${PN}-${PVR}.ebuild > /dev/null 2>&1 ; echo $SRC_URI)
TMPDIR="/tmp"
TARGZ_FILE="${TMPDIR}/${PN}-${MY_PV}.tar.gz"
OUTFILE="SUPPORTED-PRINTERS"
DL_TARGZ=
if [[ -s "/var/cache/distfiles/${PN}-${MY_PV}.tar.gz" ]] ; then
  echo "File alread in cache: ${PN}-${MY_PV}.tar.gz"
  cp "/var/cache/distfiles/${PN}-${MY_PV}.tar.gz" "${TARGZ_FILE}"
fi
test ! -e "${TARGZ_FILE}" && DL_TARGZ=1
test -n "${DL_TARGZ}" && wget -O "${TARGZ_FILE}" "${SRC_URI}"
tar -xzf "$TARGZ_FILE" --strip-components=1 --wildcards --no-anchored 'NEWS'
cat << EOF > ${OUTFILE}
List of PostScript Printer Description files (PPDs) in ${PN}-${PVR}:

EOF
tar -ztf "$TARGZ_FILE" --wildcards '*.ppd' | sed 's/epson-inkjet-printer-escpr2-.*\/ppd\///; s/-epson-escpr2-en.ppd//; s/Epson-/Epson /' | tr '_' ' ' | sort -V - >> ${OUTFILE}
test -n "${DL_TARGZ}" && rm "${TARGZ_FILE}"
