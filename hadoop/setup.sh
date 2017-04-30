#!/bin/bash

# Set up required paramters for hadoop cluster: SSH keys and IPs
#
# Usage: setup.sh <master IP> <number of slaves>

set -e

VER=2.7.3
REP=2
DATADIR=/tmp/data

while getopts m:n:v:r:d: opt
do
	case $opt in
        m) master="$OPTARG" ;;
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
export HOSTS=/tmp/hosts


# divide mater IP into prefix and suffix
master_suffix=${master##*.}
prefix=${master%.$master_suffix}


# create master ssh key
mkdir -p ssh/master
ssh-keygen -t rsa -b $KEYLEN -P '' -f ssh/master/ssh_host_rsa_key -C master

# create hosts
echo "$master hadoop-master" >> $HOSTS
for n in $(seq 1 $slaves)
do
    name=slave${n}
    ip=$prefix.$(($master_suffix + $n))
    echo "$ip $name" >> $HOSTS
done

echo HOSTS:
cat $HOSTS


# Go overslaves
for n in $(seq 1 $slaves)
do
    name=slave${n}
    ip=$prefix.$(($master_suffix + $n))

    echo "Creating $name - $ip"

    mkdir -p ssh/${name}
    ssh-keygen -t rsa -b $KEYLEN -P '' -f ssh/${name}/ssh_host_rsa_key -C $name
    echo "$name $(cat ssh/${name}/ssh_host_rsa_key.pub)" >> ssh/known_hosts

    list="$list,$name"

    mkdir -p $DATADIR/$name
    hadoop.mlab -ver $VER -replication $REP -name $name -ip $ip -datadir $DATADIR/$name -keys ssh/${name} -masterkey ssh/master/ssh_host_rsa_key.pub
done

# remove the initial comma
list=${list:1}

mkdir -p $DATADIR/hadoop-master

hadoop.mlab -ver $VER -replication $REP -name hadoop-master -ip $master  -datadir $DATADIR/hadoop-master -keys ssh/master -slaves $list -knownhosts ssh/known_hosts -hdfsweb 50070 -yarnweb 8088
