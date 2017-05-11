#!/bin/bash

# Start a zookeeper cluster with n nodes
#
# Usage: startcluster.sh [-v <version>] [-n <number of nodes>]] <first IP>

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

first_ip=$1

if [ -z "$first_ip" ]
then
    echo "Error: did not get the first IP"
    exit 1
fi

# divide mater IP into prefix and suffix
ip_suffix=${first_ip##*.}
prefix=${first_ip%.$ip_suffix}

for n in $(seq 1 $NODES)
do
    ip=$prefix.$(($ip_suffix + $n-1))
    echo "$ip server.$n" >> /tmp/hosts
    servers="$servers server.$n=$ip:2888:3888"
done

for n in $(seq 1 $NODES)
do
    ip=$prefix.$(($ip_suffix + $n-1))
    zoonode.mlab -version $VERSION -ip $ip -servers "${servers:1}" -id $n
done
