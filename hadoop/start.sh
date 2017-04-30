#!/bin/bash
set -x
set -e

while getopts n:s: opt
do
	case $opt in
		n) name="$OPTARG" ;;
		s) slaves="$OPTARG" ;;
		?) echo "unhandled option: $opt"
		   exit 1
		   ;;
		*) exit 1 ;;
	esac
done
shift $((OPTIND-1))

function start_master {
  for s in `echo $slaves | tr , ' '`
  do
    echo $s >> $HADOOP_CONF_DIR/slaves
  done

  if [ ! -d /mnt/hdfs/data ]
  then
    hdfs namenode -format
  fi
  start-dfs.sh
  start-yarn.sh

  # wait for yarn to be actually ready
  mlab detach -p :8088 -t 300s
}

function start_slave {
  echo "Launched $name"
  mlab detach
}

function start_client {
  exec bash
}

# append entries to the /hosts file (avoiding our own)
if [ -e /tmp/hosts ]
then
  grep -v "$name"  /tmp/hosts >> /etc/hosts
fi

# set up proper ssh
mkdir -p /root/.ssh
cd /root/.ssh

# copy the machine ssh keys to be also the root
cp /etc/ssh/ssh_host_rsa_key     id_rsa
cp /etc/ssh/ssh_host_rsa_key.pub id_rsa.pub

# allow master to contact us
if [ -e master.pub ]
then
  cat master.pub >> authorized_keys
  #echo "hadoop-master `cat master.pub`" >> known_hosts
fi

# allow ssh localhost
cat id_rsa.pub >> authorized_keys
chmod 0600 authorized_keys

echo "$name `cat id_rsa.pub`"      >> known_hosts
echo "localhost `cat id_rsa.pub`"  >> known_hosts
echo "0.0.0.0 `cat id_rsa.pub`"    >> known_hosts

cd /root
service ssh start

# done with ssh

case "$name" in
  hadoop-master) start_master ;;
  slave*)        start_slave  ;;
  *)             exec bash
esac

sleep 7d
