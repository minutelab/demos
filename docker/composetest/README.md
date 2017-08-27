Compose in Minute Lab
=====================

This directory contain an example of using existing Docker Compose setups inside Minute Lab.
It demonstrate how to use Minute Lab cloud proximity features in an existing compose environment.

## Using the example

### Pre-requisite

1. On-board the Minute Lab service. It is recommended to use the
   [Minute Lab's QuickStart Guide](http://docs.minutelab.io/user-guide/quickstart/).
2. Configure a shared sync that includes the example directory.
   (it is recommended to share the whole demos directory, but you can be more specific)
3. Install docker compose binary locally. A binary for linux, windows and Mac can be found in
   [github](https://github.com/docker/compose/releases). Just download the binary, rename it and put
   it in a known location (preferably in your path)

### Running the example

1. Open a shell and run `docker.mlab`
2. Open another shell window:
       a. set in the environment the environment variable `DOCKER_HOST` to `tcp://localhost:2375`
       (from bash issue `export DOCKER_HOST=tcp://localhost:2375`)
       b. Change the directory to the demo directory and run `docker-compse up`
3. From you browser access `http://localhost:5000`, and view the application
   counting the number of times this page is accessed.
4. Open `app.py` in a (local) editor and modify the code (for example the message). Save the code.
5. Reload the web page, and watch the changes take effect.

## Explanation

The `docker.mlab` starts a docker server in a Minute Lab container, that includes an independent docker setup.
It exposes the docker port (2375) as localhost. So the locally running compose can access
the remote docker.

It also exposes the application port (5000) for us to access it.
Lastly, mlab shares the whole demo directory with the docker server which in turn shares it with the container.

The result: You can work with the running environment as if docker was running locally on your Linux desktop, even though it is running somewhere in the cloud and the local desktop may be windows or mac (or linux). This also applies to code changes, which are uploaded and deployed in the running container.

## Acknowledgments

The compose example (and the application running inside) are mostly taken
from the [getting started example](https://docs.docker.com/compose/gettingstarted/)
in the docker compose documentation.
