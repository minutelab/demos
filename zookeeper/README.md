Zoo Keeper example
==================

This directory contain scripts to run a Zoo Keeper cluster with a variable number of members.
By default the name of the nodes are `node-n.zoo` (where n is 1,2,... according to the number of nodes).


The main container is `zoocluster.mlab`, that start a cluster.
The main parameters are:

* nodes - the number of nodes in the cluster (by default 3)
* datadir - if not empty allow to persist data, it can be either a volume name, or a moutned directory
  (if run from another container)
* name - the name of the cluster, by default zoo, the name of the nodes depends on this settings.
