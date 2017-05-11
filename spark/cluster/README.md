Spark cluster
=============

This directory contain script required to run a Spark cluster. It features:

 * Variable number of nodes
 * Optional persistence of data

## Running

The simplest way to run it is:

   spark.mlab -hosts <file>

Once the cluster is read the container will detach (see the next section for the meaining of the `-hosts` flag)

## Hosts file (a poor man's "DNS")

To reliably work with a spark cluster client need to have resolvable names for all the cluster members.
Since at the time of writing (May 2017) Minute Lab don't have built in DNS integration, the example uses
hosts file.

Once the cluster is ready it output a hosts file (to the place specified with the `-hosts` paramter),
this can be imported to other containers (see for example the hue and zeppelin examples)

## Data persistence

The cluster can store the data in a permanent volume, so if it stopped and restarted it will keep the data
(by default it start empty).

To specify it use the `-datadir` parameter. If the cluster is run diredtly it should specify a volume name,
like `VOLUME:spark`. If it is run from another container it can specify a (mounted directory) in the calling container.

## Number of workers

The number of workers can be specified with the `-workers` parameter

## Names

By default all the containers have names, as follows:

* cluster-spark - the container responsible for all the cluster. To stop the cluster kill it: `mlab kill cluster-spark`
* master-spark - The master spark node (which is also the hdfs name node)
* node<N>-spark - The Nth node in the cluster

There are two ways to avoid name collision:

1. If the cluster is run from another container that parent container may create a private sub-domain
2. The `-suffix` paramter can be used to replace the `-spark` suffix with another.
