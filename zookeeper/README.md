Zoo Keeper example
==================

This directory contain scripts to run a Zoo Keeper cluster with a variable number of members.

The main container is `zoocluster.mlab`, that start a cluster.
The main parameters are:

* nodes - the number of nodes in the cluster (by default 3)
* ip - The first IP in the cluster, the nodes will take consecutive addresses.
  So if this is 192.168.10.7, the addresses would be 192.168.10.7, 192.168.10.8, 192.168.10.9


The script is intended to run from the context of a larger lab that can set static addresses, like `demo.mlab`
