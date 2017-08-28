# Minute lab demos

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

The repository contains various demos and examples of building and running a [Minute Lab](http://minutelab.io) setup.

***Note:*** To use/run the demos you will need to onboard the Minute Lab service.
It is recommended to use the [Minute Lab's QuickStart Guide](http://docs.minutelab.io/user-guide/quickstart/).
Since many of the demos requirea a shared sync, it is recommended to share the whole demos directory, but you can be more specific.

* `bash` - A simple container just running bash. Shows how the bash history can be saved on desktop
  between script invocation
* `docker` - Demonstrates running docker inside Minute Lab and using Minute Lab's feature to work with it.
* `flaskr` - A simple web application composed of a web front-end and a database to demonstrate Minute Lab's features
* `hadoop` - shows a cluster of hadoop (hdfs + yarn) with variable versions and a number of slaves
* `hue` - running [Hue](http://gethue.com) in Minute Lab
* `kafka` - running a Kafka cluster in Minute Lab
* `spark` - Several examples with spark
  * `cluster` - scripts to create a spark cluster
  * `zeppelin` - running zeppelin against the spark cluster
  * `wordcount` - classic word count example with the spark cluster
* `tomcat` - show how a Java based web application can be developed and run interactively using Minute Lab.
* `volumes` - Utility containers to access data sotred on volumes
* `wordpress` - Demonstrates how to setup and run a WordPress development environment in Minute Lab
* `zookeeper` - running a Zoo Keeper cluster in Minute Lab
