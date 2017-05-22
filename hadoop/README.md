Hadoop cluster example
======================

This directory contain a Hadoop (HDFS + Yarn) cluster in a Minute Lab lab.

It contain mainly 3 containers:

* hadoop_cluster.mlab - create a cluster with a master and variable number of slaves
* hadoop.mlab create a single container that can function (according to paramters) as hadoop master,slave or just a client
* hadoop_system.mlab create a cluster, and then start another container, configure hadoop to talk to the previous run container and start bash.

## hadoop_cluster.mlab

This is the "main" part of the demo, it create a functioning cluster. And it can optionally persist data between runs.

The parameters that it get are:

* ***ver*** - Hadoop version (by default 2.7.3)
* ***nslaves*** - Number of slaves (by default 2)
* ***datavolume*** - Volume name to persist the data, if empty there will be no persistence

Once the cluster is up and ready the script would detach. The HDFS and Yarn web UI,
will be available at port 50070 and 8088 respectively.

## hadoop_system.mlab

hadoop_system uses hadoop_cluster as an example.
It runs the cluster in a private network, and launches a separate "client container" that can use the cluster.
