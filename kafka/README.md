Kafka cluster example
=====================

This directory contain scripts to run a kafka cluster with variable number of brokers.

The main container is `kafkacluster.mlab`, that start a cluster.
The main parameters are:

* nodes - the number of nodes in the cluster (by default 2)
* zookeepr - IP of a zoo keeper node
* datadir - optionally a volume to persist data.

If no datadir is given the cluster is ephemeral, data is erased when the container exits.
It can be given as `-data VOLUME:<name>` to persist the data to a volume,
Or if it run from a container it can be a shared directory in the parent container.
