#!/bin/bash

# Set up required paramters for hadoop cluster: SSH keys and IPs
#
# Usage: setup.sh [ -n <number of slaves> ] [ -v <hadoop version>] [ -d <data dir> ] [-r <replication factor>]

set -e

VER=2.7.3
REP=2
DATADIR=/tmp/data
slaves=2

while getopts n:v:r:d: opt
do
	case $opt in
		n) slaves="$OPTARG" ;;
		v) VER="$OPTARG" ;;
        r) REP="$OPTARG" ;;
        d) DATADIR="$OPTARG" ;;
		?) echo "unhandled option: $opt"
		   exit 1
		   ;;
		*) exit 1 ;;
	esac
done

shift $((OPTIND-1))

KEYLEN=1024

# create master ssh key
mkdir -p ssh/master
ssh-keygen -t rsa -b $KEYLEN -P '' -f ssh/master/ssh_host_rsa_key -C master

# Launch slave containers
for n in $(seq 1 $slaves)
do
    name=slave${n}

    echo "Creating $name"

    mkdir -p ssh/${name}
    ssh-keygen -t rsa -b $KEYLEN -P '' -f ssh/${name}/ssh_host_rsa_key -C $name
    echo "$name $(cat ssh/${name}/ssh_host_rsa_key.pub)" >> ssh/known_hosts

    list="$list,$name"

    mkdir -p $DATADIR/$name
    hadoop.mlab -ver $VER -replication $REP -name $name -datadir $DATADIR/$name -keys ssh/${name} -masterkey ssh/master/ssh_host_rsa_key.pub
done

# remove the initial comma
list=${list:1}

mkdir -p $DATADIR/hadoop-master

hadoop.mlab -ver $VER -replication $REP -name master  -datadir $DATADIR/hadoop-master -keys ssh/master -slaves $list -knownhosts ssh/known_hosts -hdfsweb 50070 -yarnweb 8088
