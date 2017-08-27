Tomcat example
==============

This example show how a web application can be developed interactively.

The general model is that code is developed locally, but is tested in a remote container.

There are to modes of operations supported in this demo

* Compile in the cloud
* Compile locally

In both modes the usage is quite similar:

1. Start a tomcat container by running the `tomcat.mlab` script
2. Modify the code as you like
3. Compile the code
4. The compiled code will be loaded automatically and ready to test
   * By default on `http://127.0.0.1:8080/hellowar/`
   * Or using the mlab UI, choosing the "web" connection

The only part that is different between the modes is how the compilation is done.
It can be done locally using the IDE or using a local maven:

```
mvn package
```


Or it can be done in the cloud by running a maven container:
```
./mvn.mlab package
```

## Remote debugging

The tomcat container also support remote debugging.
By default the remote debugging port is 5005, and if the local IDE (for example InteliJ)
is configured with this port the application can be debugged.

## Compile in the cloud

In this mode the source code is synchronized to the remote hosts,
where it is compiled by a maven container.

The maven container is defined by the script `mvn.mlab` which is a pretty generic script.
This script use a persistent maven cache on the host and it accept the normal maven command line
parameters to the internal maven.

## Compile locally

In this mode, the code is compiled locally, and the exploded web application
is synchronized with the container.
