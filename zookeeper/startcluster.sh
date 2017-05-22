#!/bin/bash

# Start a zookeeper cluster with n nodes
#
# Usage: startcluster.sh [-v <version>] [-n <number of nodes>]

set -x
set -e

NODES=3
VERSION=3.4

while getopts n:v: opt
do
	case $opt in
		n) NODES="$OPTARG" ;;
		v) VERSION="$OPTARG" ;;
		?) echo "unhandled option"
		   exit 1
		   ;;
		*) exit 1 ;;
	esac
done
shift $((OPTIND-1))

servers=$(seq -s " " $NODES | sed -e 's/\([0-9]\)/server.\1=node-\1:2888:3888/g')

for n in $(seq 1 $NODES)
do
	mkdir -p /data/server.$n/data /data/server.$n/datalog
    zoonode.mlab -id $n -version $VERSION -servers "$servers" -datadir /data/server.$n
done
