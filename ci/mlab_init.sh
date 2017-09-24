#!/bin/bash

set -e

VER=latest

usage() {
    echo "Usage: $0 [-v <version>] [-d <installation dir>] <key id> <secret key>"
    exit 1
}

DESTDIR=/usr/local/bin

while getopts v:d:h opt
do
	case $opt in
		v) VER="$OPTARG" ;;
        d) DESTDIR="$OPTARG" ;;
        h) usage ;;
		?) usage ;;
	esac
done

shift $((OPTIND-1))

KID="$1"
SECRET="$2"

if [ -z "$KID" -o -z "$SECRET" ]
then
    echo "Error: No mlab credentials"
    usage
fi

# Download lates mlab binary
cd /tmp
curl -fLO https://alpha.minutelab.io/download/${VER}/linux/mlab.gz
gunzip mlab.gz
chmod +x mlab
mkdir -p ${DESTDIR}
mv mlab ${DESTDIR}
MLAB=${DESTDIR}/mlab
${MLAB} version

date -u

# Login and configure hsots
${MLAB} config profiles add ${KID} ${SECRET}
# Show configuration
${MLAB} config servers
# Test connectivity
${MLAB} ping
