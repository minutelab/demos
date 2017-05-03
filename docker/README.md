Docker in docker example
========================

This directory contain an example of using docker in docker.

The main container here is `dind.mlab`, which run docker in docker,
optionally storing the data in a persistent volume, and releasing control to the calling script
when the docker daemon is ready.

The `example.mlab` script provide an easy example of using it. It create a private network running docker
in a fixed network inside it, and then run a separate container `dockerc.mlab` which just include a docker client
configured to work with the server that it run before.
