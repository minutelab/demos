Spark cluster
=============
This demo shows usage of a spark cluster.

The directory cluster contain scripts necessary to run a spark cluster.
The main script is `spark.mlab` which create a cluster.

It is intended to run from within a containing setup that create a private network,
and assign a static IP to the cluster master (the slaves get a dynamic IP).

The directory word count contain an example running a simple wordcount python example,
to this cluster.
