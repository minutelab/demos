Integration with Cloud CI systems
=================================

This directory contain a simple script that help integrate MinuteLab,
into builds by common CI systems such as [Travis](https://travis-ci.org),
or [bitbucket pipelines](https://bitbucket.org/product/features/pipelines).

When those systems detect a git event (commit or pull request) they create a fresh
environment (usually based on container) and run the specified tests in this environment.
The `mlab_init.sh` script can be used to install and configure a MinuteLab client in this
environment.

After the script is run you can set up with MinuteLab to augment the capabilities of the cloud CI:

 * Build complex "integration" environments to run the "unit" tests
 * Use more powerful machines to run the tests thus getting faster feedback
 * Run different part of the tests with different integration environments,
   or use variety of tools to build the product.

## Using `mlab_init.sh`

The `mlab_init.sh` can be used as is in most environments.
Just copy it to your source repository and run it as one of the first step in the CI script.

The script will:

* Download the MinuteLab client
* Login to the MinuteLab cloud management and configure the client.

To login to the MinuteLab client you need to get and configure the credentials.
The following two subsections deals with that.

### Create a MinuteLab user to represent the CI process

On the MinuteLab console create a user to represent the CI process,
and assign to it a host. It is recommended to have that host be geographically close
to the cloud CI servers.

Instead of configuring an email to this user, click create credentials and keep the generated credentials.
(after the initial creation you won't be able to see the secret key again).

The `mlab_init.sh` can be used as is in most environments.
Just copy it to your source repository and run it as one of the first step in the CI script.

### Configure the MinuteLab credentials as CloudCI "environment variables"

Normally you would not like to commit the secret credentials to source repository.
Most cloud CI system allow you to configure such parameters as environment variable,
whose value are available to running CI processes without being visible.

The details differ between the services, we give here few examples.

#### Travis CI

In the repository setting there is section named "environment variables",
add two variables for the key ID and secret (for example `MLAB_KID` and `MLAB_SECRET`).
It is recommended that you set the "Display value in build log" to false for the secret key (but not for the key id).

#### Bitbucket pipelines

In the pipelines setting there is an "environment variables" section.

where you can add two variables for the key ID and secret (for example `MLAB_KID` and `MLAB_SECRET`).
It is recommended that you the secret key as secured (but not the key id).

Note: A section named "environment variables" exist on both the repository setting and the account setting,
you can configure the variable in either location.

### Script usage

```
mlab_init.sh [-v <version>] [-d <installation dir>] <key id> <secret key>
```

The most important parameters are `key id` and `secret key` which should be the environment variables,
containing the credentials. So a simple invocation would be:

```
mlab_init.sh $MLAB_KID $MLAB_SECRET
```

#### Installation directory

By default `mlab_init.sh` download the client to `/usr/local/bin`.
In some Cloud CI environments (for example Travis-CI) this directory is write protected,
and then you can use the `-d` flag to download it elsewhere.
If you download it to place that is not in the path, you should add this to the path. For example:

```
mlab_init.sh -d $PWD/bin $MLAB_KID $MLAB_SECRET
export PATH=$PATH:$PWD/bin
```
