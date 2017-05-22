Spark cluster
=============

This directory contain script required to run a Spark cluster. It features:

 * Variable number of nodes
 * Optional persistence of data

## Running

The simplest way to run it is:

   spark.mlab

Once the cluster is read the container will detach

## Data persistence

The cluster can store the data in a permanent volume, so if it stopped and restarted it will keep the data
(by default it start empty).

To specify it use the `-datadir` parameter. If the cluster is run diredtly it should specify a volume name,
like `VOLUME:spark`. If it is run from another container it can specify a (mounted directory) in the calling container.

## Number of workers

The number of workers can be specified with the `-workers` parameter

## Names

By default all the containers have names, as follows:

* spark - the container responsible for all the cluster. To stop the cluster kill it: `mlab kill cluster-spark`
* master.spark - The master spark node (which is also the hdfs name node)
* node<N>.spark - The Nth node in the cluster

The names are both for DNS access and container names to be used by mlab commands.

There are two ways to avoid name collision:

1. If the cluster is run from another container that parent container may create a private sub-domain
2. Use the `-name` paramter. to replace the spark domain with another.

## Dynamically addig/removing nodes from cluster

Nodes can be added dynamically to existing cluster by issuing:

```
mlab exec spark start_worker <node id>
```

This command execute the script `start_worker` inside the `spark` container,
the `spark` container is the parent container that start the whole cluster.

It is started by the `spark.mlab` mlab script. That create and uses the `start_worker`
shell script to start the worker nodes. The `mlab exec` command run the same script, but on-demand.

Killing a node is even simpler:

```
mlab kill node<id>.spark
```
